# frozen_string_literal: true

RSpec.describe EventRegistration::CreateEventCommand do
  let(:store) do
    {
      events: []
    }
  end

  describe '#call' do
    describe 'with valid data' do
      let(:params) do
        {
          name: 'foo',
          date: '2024-12-12',
          limit: 10
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
        expect(result[1]).to be_a(EventRegistration::EventEntity)
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
        expect(result[1].keys).to match_array(%i[name date limit])
      end
    end
  end
end
