# frozen_string_literal: true

module EventRegistration
  class GetAvailableTicketsCountQuery
    def initialize(store)
      @store = store
    end

    def call(event_id:)
      event_entity = GetEventQuery.new(@store).call(id: event_id)
      return 0 unless event_entity

      tickets =
        @store[:tickets].select { |ticket| ticket.event_id == event_entity.id }

      event_entity.limit - tickets.size
    end
  end
end
