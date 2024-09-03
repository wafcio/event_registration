# frozen_string_literal: true

module EventRegistration
  class GetAllHashedTicketsByParticipantNameQuery
    def initialize(store)
      @store = store
    end

    def call(participant_name:)
      tickets = @store[:tickets].select { |ticket| ticket.participant_name == participant_name }
      tickets.map { |ticket| [ticket.event_id, ticket] }.to_h
    end
  end
end
