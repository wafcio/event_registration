# frozen_string_literal: true

module EventRegistration
  class CreateEventCommand
    def initialize(store)
      @store = store
    end

    def call(params)
      contract_result = EventContract.new.call(params)

      return [:error, contract_result.errors.to_h] if contract_result.failure?

      id = @store[:events].size + 1
      event_entity = EventEntity.new({ **params, id: id })
      @store[:events] << event_entity

      [:ok, event_entity]
    end
  end
end
