# frozen_string_literal: true

RSpec.describe EventRegistration::EventEntity do
  describe '#id' do
    it 'allows to set id' do
      object = described_class.new(id: 1)
      expect(object.id).to eq(1)
    end
  end

  describe '#name' do
    it 'allows to set name' do
      object = described_class.new(name: 'foo')
      expect(object.name).to eq('foo')
    end
  end

  describe '#date' do
    it 'allows to set date' do
      object = described_class.new(date: '2024-12-12')
      expect(object.date).to eq('2024-12-12')
    end
  end

  describe '#limit' do
    it 'allows to set date' do
      object = described_class.new(limit: 10)
      expect(object.limit).to eq(10)
    end
  end

  describe '#attributes' do
    it 'returns hash with attributes' do
      object = described_class.new
      expect(object.attributes).to be_a(Hash)
      expect(object.attributes.keys)
        .to match_array(%i[id name date limit])
    end
  end

  describe '#update' do
    it 'allows to update attributes' do
      object = described_class.new
      object.update(
        name: :name, date: :date, limie: :limit
      )

      expect(object.name).to eq(:name)
      expect(object.date).to eq(:date)
    end
  end
end
