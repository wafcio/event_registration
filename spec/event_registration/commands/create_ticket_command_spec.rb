# frozen_string_literal: true

RSpec.describe EventRegistration::CreateTicketCommand do
  let(:store) do
    {
      events: [
        EventRegistration::EventEntity.new(id: 1, limit: 10)
      ],
      tickets: []
    }
  end

  describe '#call' do
    describe 'with valid data' do
      let(:params) do
        {
          event_id: 1,
          participant_name: 'John Doe',
          status: 'unapproved'
        }
      end

      it 'returns ok' do
        result = described_class.new(store).call(params)

        expect(result).to be_an(Array)
        expect(result[0]).to eq(:ok)
      end

      it 'return saved entity' do
        result = described_class.new(store).call(params)

        expect(result).to be_an(Array)
        expect(result[1]).to be_a(EventRegistration::TicketEntity)
      end
    end

    describe 'with invalid data' do
      let(:params) do
        {}
      end

      it 'returns error' do
        result = described_class.new(store).call(params)

        expect(result).to be_an(Array)
        expect(result[0]).to eq(:error)
      end

      it 'return saved entity' do
        result = described_class.new(store).call(params)

        expect(result).to be_an(Array)
        expect(result[1]).to be_a(Hash)
        expect(result[1].keys).to match_array(%i[event_id participant_name status])
      end
    end
  end
end
