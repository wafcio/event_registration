# frozen_string_literal: true

module EventRegistration
  class TicketContract < Dry::Validation::Contract
    params do
      required(:event_id).filled
      required(:participant_name).filled(:string)
      required(:status).filled
    end

    rule(:status) do
      key.failure('is invalid') unless %w[unapproved approved rejected].include?(values[:status])
    end
  end
end
