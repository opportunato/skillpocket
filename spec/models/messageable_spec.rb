RSpec.shared_examples_for Messageable  do |factory|
  describe '#conversation_with' do
    context 'with a bunch of messages' do
      before do
        @sender = create factory
        @recipient = create factory
        @someone = create factory
        @sender.send_message_to @recipient, 'hello'
      end

      it 'is visible by sender' do
        conversation = @sender.conversation_with @recipient
        expect(conversation.count).to eq 1
        expect(conversation.first.body).to eq 'hello'
        expect(conversation.first.sender).to eq @sender
        expect(conversation.first.recipient).to eq @recipient
      end

      it 'is visible by recipient' do
        conversation = @recipient.conversation_with @sender
        expect(conversation.count).to eq 1
        expect(conversation.first.body).to eq 'hello'
        expect(conversation.first.sender).to eq @sender
        expect(conversation.first.recipient).to eq @recipient
      end
    end

    context 'with a bunch of messages' do
      before do
        @sender = create factory
        @recipient = create factory
        @someone = create factory
        @sender.send_message_to @recipient, 'hello'
        @recipient.send_message_to @sender, 'hi'
        @someone.send_message_to @recipient, 'wtf'
        @someone.send_message_to @sender, 'loser'
      end

      it 'is only visible by participants' do
        conversation = @someone.conversation_with @sender
        expect(conversation.count).to eq 1
        expect(conversation.first.body).to eq 'loser'
        conversation = @someone.conversation_with @recipient
        expect(conversation.count).to eq 1
        expect(conversation.first.body).to eq 'wtf'
      end

      it 'is all visible by participants' do
        conversation = @sender.conversation_with @recipient
        expect(conversation.count).to eq 2
        expect(conversation.first.body).to eq 'hi'
        expect(conversation.last.body).to eq 'hello'

        conversation = @recipient.conversation_with @sender
        expect(conversation.count).to eq 2
        expect(conversation.first.body).to eq 'hi'
        expect(conversation.last.body).to eq 'hello'
      end
    end
  end

  describe '#conversations' do
    context 'many participants' do
      before do
        @sender = create factory
        @recipient = create factory
        @another = create factory
        @someone = create factory
        @sender.send_message_to @recipient, 'hello'
        @recipient.send_message_to @sender, 'hi'
        @another.send_message_to @sender, 'blah'
        @someone.send_message_to @recipient, 'loser'
        @someone.send_message_to @another, 'wtf'
      end

      it 'provides a list of all conversations' do
        conversations = @sender.conversations
        expect(conversations.count).to eq 2
        expect(conversations).to eq({ @recipient => 1, @another => 1 })
      end
    end
  end
end
