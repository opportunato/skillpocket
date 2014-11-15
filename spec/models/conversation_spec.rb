require 'rails_helper'

RSpec.describe Conversation do
  describe 'Associations' do
    it { is_expected.to belong_to(:newer).class_name('User') }
    it { is_expected.to belong_to(:older).class_name('User') }
  end

  describe 'counter caches' do
    let(:alice) { create :user }
    let(:bob) { create :user }
    let(:conversation) { create :conversation, older: alice, newer: bob }
    let!(:read) { create(:message, conversation: conversation, sender: bob, recipient: alice) }
    before do
      @messages = [
        create(:message, conversation: conversation, sender: alice, recipient: bob, is_read: false),
        create(:message, conversation: conversation, sender: bob, recipient: alice, is_read: false)
      ]
    end

    it 'counts unread for recipient' do
      expect(conversation.unread_count(alice)).to eq 1
      expect(conversation.unread_count(bob)).to eq 1
    end

    describe 'updates counts when message is being read' do
      before do
        message = @messages.first
        message.is_read = true
        message.save
        @conversation = conversation.reload
      end

      specify { expect(conversation.unread_count(bob)).to eq 0 }

      it 'counts separately for sender and recipient' do
        expect(@conversation.unread_count(alice)).to eq 1
      end
    end
  end
end
