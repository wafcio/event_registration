# frozen_string_literal: true

RSpec.describe EventRegistration::GetEventQuery do
  let(:store) do
    {
      events: [
        EventRegistration::EventEntity.new(id: 1)
      ]
    }
  end

  describe '#call' do
    context 'when event does not exist' do
      it 'return nil' do
        result = described_class.new(store).call(id: 2)

        expect(result).to be_nil
      end
    end

    context 'when event exists' do
      it 'return event entity' do
        result = described_class.new(store).call(id: 1)

        expect(result).to be_a(EventRegistration::EventEntity)
      end
    end
  end
end
