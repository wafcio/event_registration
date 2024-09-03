# frozen_string_literal: true

RSpec.describe EventRegistration::GetAllEventsByParticipantNameQuery do
  let(:store) do
    {
      events: [
        EventRegistration::EventEntity.new(id: 1, name: 'Foo', date: '2024-10-10'),
        EventRegistration::EventEntity.new(id: 2, name: 'Bar', date: '2024-11-11'),
        EventRegistration::EventEntity.new(id: 3, name: 'DooBar', date: '2024-12-12')
      ],
      tickets: [
        EventRegistration::TicketEntity.new(id: 1, event_id: 1, participant_name: 'John Doe', status: 'unapproved'),
        EventRegistration::TicketEntity.new(id: 1, event_id: 2, participant_name: 'John Doe', status: 'approved')
      ]
    }
  end

  describe '#call' do
    context 'when ticket does not exist for participant name' do
      it 'returns empty array' do
        results = described_class.new(store).call(participant_name: 'Jane Doe')

        expect(results).to eq([])
      end
    end

    context 'when tickets exist for participant name' do
      it 'returns empty array' do
        results = described_class.new(store).call(participant_name: 'John Doe')

        expect(results).to be_an(Array)
        expect(results.size).to eq(2)
        expect(results[0]).to be_a(Hash)
        expect(results[0].keys).to match_array(%i[event ticket])
      end
    end
  end
end
