# frozen_string_literal: true

module EventRegistration
  class GetAllTicketsByEventQuery
    def initialize(store)
      @store = store
    end

    def call(event_id:)
      @store[:tickets].select { |ticket| ticket.event_id == event_id }
    end
  end
end
