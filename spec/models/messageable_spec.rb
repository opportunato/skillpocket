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

  describe '#send_message_to also sends push notification' do
    let(:recipient) { create :user_with_ios_device_token }
    let(:sender) { create :user }
    let(:body) { Faker::Lorem.sentence }

    before do
      allow(AppleNotificationPusher).to receive(:push).with(recipient.ios_device_token, body)
    end

    specify do
      expect(AppleNotificationPusher).to receive(:push).with(recipient.ios_device_token, body)
      sender.send_message_to recipient, body
    end
  end
end
