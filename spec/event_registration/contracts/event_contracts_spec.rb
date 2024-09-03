# frozen_string_literal: true

RSpec.describe EventRegistration::EventContract do
  describe 'name validation' do
    it 'is valid when filled' do
      result = described_class.new.call(name: 'foo')
      errors = result.errors
      expect(errors[:name]).to be_nil
    end

    it 'is invalid when empty' do
      result = described_class.new.call(name: nil)
      errors = result.errors
      expect(errors[:name]).not_to be_nil
    end
  end

  describe 'date validation' do
    context 'when filled' do
      it 'is valid with string date' do
        result = described_class.new.call(date: '2024-12-12')
        errors = result.errors
        expect(errors[:date]).to be_nil
      end

      it 'is invalid with any string' do
        result = described_class.new.call(date: 'foo')
        errors = result.errors
        expect(errors[:date]).not_to be_nil
      end
    end

    it 'is invalid when empty' do
      result = described_class.new.call(date: nil)
      errors = result.errors
      expect(errors[:date]).not_to be_nil
    end
  end
end
