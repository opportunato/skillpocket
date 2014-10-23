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
        messages = @sender.conversation_with(@recipient).messages
        expect(messages.count).to eq 1
        expect(messages.first.body).to eq 'hello'
        expect(messages.first.sender).to eq @sender
        expect(messages.first.recipient).to eq @recipient
      end

      it 'is visible by recipient' do
        messages = @recipient.conversation_with(@sender).messages
        expect(messages.count).to eq 1
        expect(messages.first.body).to eq 'hello'
        expect(messages.first.sender).to eq @sender
        expect(messages.first.recipient).to eq @recipient
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
        messages = @someone.conversation_with(@sender).messages
        expect(messages.count).to eq 1
        expect(messages.first.body).to eq 'loser'
        messages = @someone.conversation_with(@recipient).messages
        expect(messages.count).to eq 1
        expect(messages.first.body).to eq 'wtf'
      end

      it 'is all visible by sender' do
        messages = @sender.conversation_with(@recipient).messages
        expect(messages.count).to eq 2
        expect(messages.first.body).to eq 'hi'
        expect(messages.last.body).to eq 'hello'
      end

      it 'is visible by recipient' do
        messages = @recipient.conversation_with(@sender).messages
        expect(messages.count).to eq 2
        expect(messages.first.body).to eq 'hi'
        expect(messages.last.body).to eq 'hello'
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

      it 'provides a list of recent conversations' do
        recent = @sender.recent
        expect(recent.map &:body).to eq ['blah', 'hi', 'hello']
      end
    end
  end
end
