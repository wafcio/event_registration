# frozen_string_literal: true

require 'tty-prompt'

require_relative 'lib/event_registration'

prompt = TTY::Prompt.new

loop do # rubocop:disable Metrics/BlockLength
  value =
    prompt.select(
      'What do you want to do?',
      [
        { value: :new_event, name: 'Create new event' },
        { value: :register_participant, name: 'Register participant' },
        { value: :manage_participant, name: 'Manage participant' },
        { value: :display_participants, name: 'Display all participants for a specific event' },
        { value: :display_participant_events, name: 'Display all events I am registered for' },
        { value: :exit, name: 'Exit' }
      ]
    )

  case value
  when :new_event
    name = nil
    loop do
      name = prompt.ask('Event name: ')

      result = EventRegistration::EventContract.new.call(name: name)
      error_messages = result.errors.to_h[:name]
      break if error_messages.nil?

      puts error_messages[0]
    end

    date = nil
    loop do
      date = prompt.ask('Event date (YYYY-MM-DD): ')

      result = EventRegistration::EventContract.new.call(date: date)
      error_messages = result.errors.to_h[:date]
      break if error_messages.nil?

      puts error_messages[0]
    end

    limit = nil
    loop do
      limit = prompt.ask('Number of tickets: ')

      result = EventRegistration::EventContract.new.call(limit: limit)
      error_messages = result.errors.to_h[:limit]
      break if error_messages.nil?

      puts error_messages[0]
    end

    EventRegistration.create_event(name: name, date: date, limit: limit)
  when :register_participant
    event_id =
      prompt.select(
        'Choose event',
        EventRegistration.all_events.map { |event| { value: event.id, name: event.name } }
      ).to_i

    if EventRegistration.available_tickets?(event_id: event_id)
      participant_name = nil
      loop do
        participant_name = prompt.ask('Participant name: ')

        result = EventRegistration::TicketContract.new.call(participant_name: participant_name)
        error_messages = result.errors.to_h[:name]
        break if error_messages.nil?

        puts error_messages[0]
      end

      EventRegistration.register_participant(event_id: event_id, participant_name: participant_name)
    else
      puts 'No available tickets in selected event'
    end

  when :manage_participant
    event_id =
      prompt.select(
        'Choose event',
        EventRegistration.all_events.map { |event| { value: event.id, name: event.name } }
      ).to_i

    selected_ticket =
      prompt.select(
        'Choose participant',
        EventRegistration.all_tickets_by_event(event_id: event_id).map do |ticket|
          { value: ticket, name: ticket.participant_name }
        end
      )

    puts "Participant ticket status: #{selected_ticket.status}"

    new_status =
      prompt.select(
        'Choose new status',
        [
          { value: 'unapproved', name: 'Unapproved' },
          { value: 'approved', name: 'Approved' },
          { value: 'rejected', name: 'Rejected' }
        ]
      )

    EventRegistration.update_ticket(selected_ticket.id, status: new_status)

  when :display_participants
    event_id =
      prompt.select(
        'Choose event',
        EventRegistration.all_events.map { |event| { value: event.id, name: event.name } }
      ).to_i

    puts 'List of participants:'
    tickets = EventRegistration.all_tickets_by_event(event_id: event_id)
    tickets.sort_by(&:participant_name).each do |ticket|
      puts "#{ticket.participant_name} (#{ticket.status})"
    end
    puts

  when :display_participant_events
    participant_name = nil
    loop do
      participant_name = prompt.ask('Participant name: ')

      result = EventRegistration::TicketContract.new.call(participant_name: participant_name)
      error_messages = result.errors.to_h[:name]
      break if error_messages.nil?

      puts error_messages[0]
    end

    puts 'List of events:'
    results = EventRegistration.all_events_by_participant_name(participant_name: participant_name)
    results.sort_by { |el| el[:event].date }.each do |element|
      puts "#{element[:event].date} #{element[:event].name} (status: #{element[:ticket].status})"
    end
    puts

  when :exit
    break
  end
end
