# frozen_string_literal: true

module EventRegistration
  class GetEventQuery
    def initialize(store)
      @store = store
    end

    def call(id:)
      @store[:events].find { |event| event.id == id }
    end
  end
end
