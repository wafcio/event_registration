# frozen_string_literal: true

RSpec.describe EventRegistration::GetAvailableTicketsCountQuery do
  let(:store) do
    {
      events: [
        EventRegistration::EventEntity.new(id: 1, limit: 10),
        EventRegistration::EventEntity.new(id: 2, limit: 1)
      ],
      tickets: [
        EventRegistration::TicketEntity.new(
          name: 'foobar', event_id: 1
        ),
        EventRegistration::TicketEntity.new(
          name: 'foobar2', event_id: 2
        )
      ]
    }
  end

  describe '#call' do
    context 'when tickets left' do
      it 'returns positive value' do
        count = described_class.new(store).call(event_id: 1)

        expect(count).to eq(9)
      end
    end
  end
end
