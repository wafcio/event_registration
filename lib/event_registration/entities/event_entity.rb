# frozen_string_literal: true

module EventRegistration
  class EventEntity
    attr_accessor :id, :name, :date, :limit

    def initialize(params = {})
      @id = params[:id]
      update(params)
    end

    def attributes
      {
        id: id,
        name: name,
        date: date,
        limit: limit
      }
    end

    def update(params)
      @name = params[:name] if params.keys.include?(:name)
      @date = params[:date] if params.keys.include?(:date)
      @limit = params[:limit].to_i if params.keys.include?(:limit)
    end
  end
end
