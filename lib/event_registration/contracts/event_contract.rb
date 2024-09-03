# frozen_string_literal: true

module EventRegistration
  class EventContract < Dry::Validation::Contract
    register_macro(:date_format) do
      key.failure('not a valid date format') unless /\A\d{4}-\d{2}-\d{2}\z/i.match?(value)
    end

    params do
      required(:name).filled(:string)
      required(:date).filled
      required(:limit).filled(:integer)
    end

    rule(:date).validate(:date_format)
  end
end
