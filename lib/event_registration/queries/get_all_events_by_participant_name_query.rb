# frozen_string_literal: true

module EventRegistration
  class GetAllEventsByParticipantNameQuery
    def initialize(store)
      @store = store
    end

    def call(participant_name:)
      hashed_tickets = GetAllHashedTicketsByParticipantNameQuery.new(@store).call(participant_name: participant_name)
      event_ids = hashed_tickets.keys

      events = @store[:events].select { |event| event_ids.include?(event.id) }

      events.map do |event|
        {
          event: event,
          ticket: hashed_tickets[event.id]
        }
      end
    end
  end
end
