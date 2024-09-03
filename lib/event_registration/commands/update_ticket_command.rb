# frozen_string_literal: true

module EventRegistration
  class UpdateTicketCommand
    def initialize(store)
      @store = store
    end

    def call(id, params)
      ticket_entity = @store[:tickets].find { |ticket| ticket.event_id == id }

      return [:error, 'not found'] unless ticket_entity

      update_params = ticket_entity.attributes.merge(params.compact)
      contract_result = TicketContract.new.call(update_params)

      return [:error, contract_result.errors.to_h] if contract_result.failure?

      ticket_entity.update(params)

      [:ok, ticket_entity]
    end
  end
end
