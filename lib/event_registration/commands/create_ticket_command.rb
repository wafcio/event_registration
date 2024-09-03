# frozen_string_literal: true

module EventRegistration
  class CreateTicketCommand
    def initialize(store)
      @store = store
    end

    def call(params)
      contract_result = TicketContract.new.call(params)
      return [:error, contract_result.errors.to_h] if contract_result.failure?

      available_ticket_count = GetAvailableTicketsCountQuery.new(@store).call(event_id: params[:event_id])
      return [:error, 'no more tickets'] unless available_ticket_count.positive?

      id = @store[:tickets].size + 1
      ticket_entity = TicketEntity.new({ **params, id: id })
      @store[:tickets] << ticket_entity

      [:ok, ticket_entity]
    end
  end
end
