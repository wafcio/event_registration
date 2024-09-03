# frozen_string_literal: true

RSpec.describe EventRegistration::TicketEntity do
  describe '#id' do
    it 'allows to set id' do
      object = described_class.new(id: 1)
      expect(object.id).to eq(1)
    end
  end

  describe '#event_id' do
    it 'allows to set event_id' do
      object = described_class.new(event_id: 2)
      expect(object.event_id).to eq(2)
    end
  end

  describe '#participant_name' do
    it 'allows to set participant_name' do
      object = described_class.new(participant_name: 'John Doe')
      expect(object.participant_name).to eq('John Doe')
    end
  end

  describe '#status' do
    it 'allows to set status' do
      object = described_class.new(status: 'unapproved')
      expect(object.status).to eq('unapproved')
    end
  end

  describe '#attributes' do
    it 'returns hash with attributes' do
      object = described_class.new
      expect(object.attributes).to be_a(Hash)
      expect(object.attributes.keys)
        .to match_array(%i[id event_id participant_name status])
    end
  end

  describe '#update' do
    it 'allows to update attributes' do
      object = described_class.new
      object.update(
        event_id: :event_id, participant_name: :participant_name, status: :status
      )

      expect(object.event_id).to eq(:event_id)
      expect(object.participant_name).to eq(:participant_name)
      expect(object.status).to eq(:status)
    end
  end
end
