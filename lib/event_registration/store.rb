# frozen_string_literal: true

module EventRegistration
  class Store
    def initialize
      @store = {
        events: [],
        tickets: []
      }
    end

    def [](key)
      @store[key]
    end

    def []=(key, value)
      @store[key] = value
    end
  end
end
