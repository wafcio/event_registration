# frozen_string_literal: true

RSpec.describe EventRegistration::GetAllEventsQuery do
  let(:store) do
    {
      events: [1, 2]
    }
  end

  describe '#call' do
    it 'returns all events from store' do
      results = described_class.new(store).call
      expect(results).to eq(store[:events])
    end
  end
end
