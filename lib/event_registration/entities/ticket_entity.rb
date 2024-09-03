# frozen_string_literal: true

module EventRegistration
  class TicketEntity
    attr_accessor :id, :event_id, :participant_name, :status

    def initialize(params = {})
      @id = params[:id]
      update(params)
    end

    def attributes
      {
        id: id,
        event_id: event_id,
        participant_name: participant_name,
        status: status
      }
    end

    def update(params)
      @event_id = params[:event_id] if params.keys.include?(:event_id)
      @participant_name = params[:participant_name] if params.keys.include?(:participant_name)
      @status = params[:status] || 'unapproved'
    end
  end
end
