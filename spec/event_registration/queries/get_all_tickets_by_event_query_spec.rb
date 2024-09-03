# frozen_string_literal: true

require 'ostruct'

RSpec.describe EventRegistration::GetAllTicketsByEventQuery do
  let(:store) do
    {
      tickets: [
        OpenStruct.new(name: 'foobar', event_id: 1),
        OpenStruct.new(name: 'foobar2', event_id: 2)
      ]
    }
  end

  describe '#call' do
    it 'returns all events from store' do
      results = described_class.new(store).call(event_id: 2)
      expect(results).to be_an(Array)
      expect(results.size).to eq(1)
      expect(results[0].name).to eq('foobar2')
      expect(results[0].event_id).to eq(2)
    end
  end
end
