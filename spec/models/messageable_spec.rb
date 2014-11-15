RSpec.shared_examples_for Messageable  do |factory|
  describe '#messages_with' do
    context 'with a bunch of messages' do
      before do
        @sender = create factory
        @recipient = create factory
        @someone = create factory
        @sender.send_message_to @recipient, 'hello'
      end

      it 'is visible by sender' do
        messages = @sender.messages_with(@recipient)
        expect(messages.count).to eq 1
        expect(messages.first.body).to eq 'hello'
        expect(messages.first.sender).to eq @sender
        expect(messages.first.recipient).to eq @recipient
      end

      it 'is visible by recipient' do
        messages = @recipient.messages_with(@sender)
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
        messages = @someone.messages_with(@sender)
        expect(messages.count).to eq 1
        expect(messages.first.body).to eq 'loser'
        messages = @someone.messages_with(@recipient)
        expect(messages.count).to eq 1
        expect(messages.first.body).to eq 'wtf'
      end

      it 'is all visible by sender' do
        messages = @sender.messages_with(@recipient)
        expect(messages.count).to eq 2
        expect(messages.first.body).to eq 'hi'
        expect(messages.last.body).to eq 'hello'
      end

      it 'is visible by recipient' do
        messages = @recipient.messages_with(@sender)
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
        @recipient.send_message_to @sender, 'hi' # First with @recipient
        @another.send_message_to @sender, 'yo'
        @another.send_message_to @sender, 'blah' # Another with @another
        @someone.send_message_to @recipient, 'loser'
        @someone.send_message_to @another, 'wtf' # Irrelevant
      end

      it 'provides a list of recent conversations' do
        recent = @sender.recent
        expect(recent.map &:body).to eq ['blah', 'hi']
      end
    end
  end

  describe '#send_message_to also sends push notification' do
    let(:recipient) { create :user_with_ios_device_token }
    let(:sender) { create :user }
    let(:body) { "#{sender.full_name} have sent you a message" }

    #FIXME: omg, should double be set up to allow or expect? why does it fail if only either is used?
    before do
      allow(AppleNotificationPusher).to receive(:push).with(recipient.ios_device_token, body, sender.id, 1)
    end

    specify do
      expect(AppleNotificationPusher).to receive(:push).with(recipient.ios_device_token, body, sender.id, 1)
      sender.send_message_to recipient, body
    end

    it 'should have correct unread'
  end

  describe '#send_message_to denies to send to himself' do
    let(:user) { create :user }
    let(:same) { User.find_by_full_name user.full_name }
    let(:body) { 'hello' }

    it 'for #send_message_to' do
      expect { user.send_message_to same, body }.to raise_error
    end

    it 'for #messages_with' do
      expect { user.messages_with same }.to raise_error
    end

    it 'for #conversation_with' do
      expect { user.conversation_with same }.to raise_error
    end
  end
end
