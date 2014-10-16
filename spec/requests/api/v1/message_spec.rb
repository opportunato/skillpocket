require 'rails_helper'

RSpec.describe Api::V1::MessageController do
  # it_behaves_like 'token protected resource'

  # it 'rejects new message with no recipient'
  # it 'rejects new message with no text'

  describe 'sends a new message to an expert' do
    it do
      consumer = create :user
      expert = create :skilled_user
      body = Faker::Lorem.sentence

      post api_v1_message_path(expert.id), { text: body }, authorization: ActionController::HttpAuthentication::Token.encode_credentials(consumer.access_token)

      expect(response.status).to eq 201
      expect(response.body).to be_blank

      # expect(consumer).to receive(:send_message_to).with(expert, body)
    end
  end

  describe 'replies to a message' do
    it do
      consumer = create :user
      expert = create :skilled_user
      body = Faker::Lorem.sentence
      consumer.send_message_to(expert, body)
      reply = Faker::Lorem.sentence

      post api_v1_message_path(consumer.id), { text: reply }, authorization: ActionController::HttpAuthentication::Token.encode_credentials(expert.access_token)

      expect(response.status).to eq 201
      expect(response.body).to be_blank

      # expect(expert).to receive(:send_message_to).with(consumer, reply)
    end
  end

  describe do
    context 'no messages' do
      before(:each) do
        @consumer = create :user
        @expert = create :skilled_user
      end

      it 'is an empty list' do
        get api_v1_message_path(@expert.id), nil, authorization: ActionController::HttpAuthentication::Token.encode_credentials(@consumer.access_token)

        expect(response.status).to eq 200
        expect(response_json).to eq([])
      end
    end

    context 'some messages' do
      before(:each) do
        @consumer = create :user
        @expert = create :skilled_user
        Timecop.freeze(Time.at(1413234000)) { @consumer.send_message_to(@expert, 'Hi') }
        Timecop.freeze(Time.at(1413234111)) { @expert.send_message_to(@consumer, 'Hello') }
        Timecop.freeze(Time.at(1413234222)) { @consumer.send_message_to(@expert, 'Hi') }
        Timecop.freeze(Time.at(1413234333)) { @expert.send_message_to(@consumer, 'Hello back') }
        Timecop.freeze(Time.at(1413234444)) { @expert.send_message_to(@consumer, 'Ready, let`s roll') }
      end

      it 'lists customers messages' do
        get api_v1_message_path(@expert.id), nil, authorization: ActionController::HttpAuthentication::Token.encode_credentials(@consumer.access_token)

        expect(response.status).to eq 200
        expect(response_json).to eq([
         {"incoming"=>false, "read"=>false, "date"=>1413234444, "message"=>"Ready, let`s roll" },
         {"incoming"=>false, "read"=>false, "date"=>1413234333, "message"=>"Hello back" },
         {"incoming"=>true,  "read"=>true,  "date"=>1413234222, "message"=>"Hi" },
         {"incoming"=>false, "read"=>false, "date"=>1413234111, "message"=>"Hello" },
         {"incoming"=>true,  "read"=>true,  "date"=>1413234000, "message"=>"Hi" }
        ])
      end

      it 'lists expert messages' do
        get api_v1_message_path(@consumer.id), nil, authorization: ActionController::HttpAuthentication::Token.encode_credentials(@expert.access_token)

        expect(response.status).to eq 200
        expect(response_json).to eq([
         {"incoming"=>true,  "read"=>true,  "date"=>1413234444, "message"=>"Ready, let`s roll" },
         {"incoming"=>true,  "read"=>true,  "date"=>1413234333, "message"=>"Hello back" },
         {"incoming"=>false, "read"=>false, "date"=>1413234222, "message"=>"Hi" },
         {"incoming"=>true,  "read"=>true,  "date"=>1413234111, "message"=>"Hello" },
         {"incoming"=>false, "read"=>false, "date"=>1413234000, "message"=>"Hi" }
        ])
      end
    end

    context 'lots of messages' do
      # TODO pagination

    end
  end
end
