# frozen_string_literal: true

RSpec.describe EventRegistration::UpdateTicketCommand do
  let(:store) do
    {
      tickets: [
        EventRegistration::TicketEntity.new(
          id: 1, event_id: 123, participant_name: 'John Doe', status: 'unapproved'
        )
      ]
    }
  end

  describe '#call' do
    context 'when ticket does not exist' do
      it 'returns error' do
        result = described_class.new(store).call(1, {})

        expect(result).to be_an(Array)
        expect(result[0]).to eq(:error)
      end
    end

    context 'when ticket exists' do
      context 'and data are invalid' do
        it 'returns error' do
          result = described_class.new(store).call(123, status: 'foo')

          expect(result).to be_an(Array)
          expect(result[0]).to eq(:error)
        end
      end

      context 'and data are valid' do
        it 'returns error' do
          result = described_class.new(store).call(123, status: 'approved')

          expect(result).to be_an(Array)
          expect(result[0]).to eq(:ok)
        end
      end
    end
  end
end
