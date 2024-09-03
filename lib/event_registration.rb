# frozen_string_literal: true

require 'dry/validation'

require_relative 'event_registration/commands/create_event_command'
require_relative 'event_registration/commands/create_ticket_command'
require_relative 'event_registration/commands/update_ticket_command'
require_relative 'event_registration/contracts/event_contract'
require_relative 'event_registration/contracts/ticket_contract'
require_relative 'event_registration/entities/event_entity'
require_relative 'event_registration/entities/ticket_entity'
require_relative 'event_registration/queries/get_all_events_by_participant_name_query'
require_relative 'event_registration/queries/get_all_events_query'
require_relative 'event_registration/queries/get_all_hashed_tickets_by_participant_name_query'
require_relative 'event_registration/queries/get_all_tickets_by_event_query'
require_relative 'event_registration/queries/get_available_tickets_count_query'
require_relative 'event_registration/queries/get_event_query'
require_relative 'event_registration/store'

module EventRegistration
  def self.store
    @store ||= Store.new
  end

  def self.create_event(params)
    CreateEventCommand.new(store).call(params)
  end

  def self.all_events
    GetAllEventsQuery.new(store).call
  end

  def self.available_tickets?(event_id:)
    GetAvailableTicketsCountQuery.new(store).call(event_id: event_id).positive?
  end

  def self.register_participant(params)
    CreateTicketCommand.new(store).call({ **params, status: 'unapproved' })
  end

  def self.all_tickets_by_event(event_id:)
    GetAllTicketsByEventQuery.new(store).call(event_id: event_id)
  end

  def self.update_ticket(id, params)
    UpdateTicketCommand.new(store).call(id, params)
  end

  def self.all_events_by_participant_name(participant_name:)
    GetAllEventsByParticipantNameQuery.new(store).call(participant_name: participant_name)
  end
end
