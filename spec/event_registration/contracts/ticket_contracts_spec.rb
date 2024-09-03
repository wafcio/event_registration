# frozen_string_literal: true

RSpec.describe EventRegistration::TicketContract do
  describe 'event_id validation' do
    it 'is valid when filled' do
      result = described_class.new.call(event_id: 1)
      errors = result.errors
      expect(errors[:event_id]).to be_nil
    end

    it 'is invalid when empty' do
      result = described_class.new.call(event_id: nil)
      errors = result.errors
      expect(errors[:event_id]).not_to be_nil
    end
  end

  describe 'participant_name validation' do
    it 'is valid when filled' do
      result = described_class.new.call(participant_name: 'John Doe')
      errors = result.errors
      expect(errors[:participant_name]).to be_nil
    end

    it 'is invalid when empty' do
      result = described_class.new.call(participant_name: nil)
      errors = result.errors
      expect(errors[:participant_name]).not_to be_nil
    end
  end

  describe 'status validation' do
    context 'when filled' do
      it 'is valid with string date' do
        result = described_class.new.call(status: 'approved')
        errors = result.errors
        expect(errors[:status]).to be_nil
      end

      it 'is invalid with any string' do
        result = described_class.new.call(status: 'foo')
        errors = result.errors
        expect(errors[:status]).not_to be_nil
      end
    end

    it 'is invalid when empty' do
      result = described_class.new.call(status: nil)
      errors = result.errors
      expect(errors[:status]).not_to be_nil
    end
  end
end
