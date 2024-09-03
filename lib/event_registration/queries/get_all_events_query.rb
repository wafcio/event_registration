# frozen_string_literal: true

module EventRegistration
  class GetAllEventsQuery
    def initialize(store)
      @store = store
    end

    def call
      @store[:events]
    end
  end
end
