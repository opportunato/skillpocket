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

      login_as(consumer)
      post api_v1_message_path(expert.id), { text: body }

      expect(response.status).to eq 201
      expect(response.content_type).to eq 'application/json'
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

      login_as(expert)
      post api_v1_message_path(consumer.id), { text: reply }

      expect(response.status).to eq 201
      expect(response.content_type).to eq 'application/json'
      expect(response.body).to be_blank

      # expect(expert).to receive(:send_message_to).with(consumer, reply)
    end
  end

  describe 'lists messages' do
    context 'no such respondent' do
      before(:each) do
        @consumer = create :user
      end

      it 'is an empty list' do
        login_as(@consumer)
        get api_v1_message_path(rand(10000000..20000000)), nil

        expect(response.status).to eq 200
        expect(response_json).to eq([])
      end
    end

    context 'no messages' do
      before(:each) do
        @consumer = create :user
        @expert = create :skilled_user
      end

      it 'is an empty list' do
        login_as(@consumer)
        get api_v1_message_path(@expert.id), nil

        expect(response.status).to eq 200
        expect(response_json).to eq([])
      end
    end

    context 'some messages' do
      before(:each) do
        @consumer = create :user
        @expert = create :skilled_user
        @expert2 = create :skilled_user
        Timecop.freeze(Time.at(1413234000)) { @consumer.send_message_to(@expert, 'Hi') }
        Timecop.freeze(Time.at(1413234111)) { @expert.send_message_to(@consumer, 'Hello') }
        Timecop.freeze(Time.at(1413234222)) { @consumer.send_message_to(@expert, 'Hi') }
        Timecop.freeze(Time.at(1413234333)) { @expert.send_message_to(@consumer, 'Hello back') }
        Timecop.freeze(Time.at(1413234444)) { @expert.send_message_to(@consumer, 'Ready, let`s roll') }
      end

      it 'lists customers messages' do
        login_as(@consumer)
        get api_v1_message_path(@expert.id), nil

        expect(response.status).to eq 200
        expect(response_json).to eq([
         {"incoming"=>true,  "read"=>false, "date"=>1413234444, "message"=>"Ready, let`s roll" },
         {"incoming"=>true,  "read"=>false, "date"=>1413234333, "message"=>"Hello back" },
         {"incoming"=>false, "read"=>true,  "date"=>1413234222, "message"=>"Hi" },
         {"incoming"=>true,  "read"=>false, "date"=>1413234111, "message"=>"Hello" },
         {"incoming"=>false, "read"=>true,  "date"=>1413234000, "message"=>"Hi" }
        ])
      end

      it 'is unable to read other customers messages' do
        login_as(@expert2)
        get api_v1_message_path(@consumer.id), nil

        expect(response.status).to eq 200
        expect(response_json).to eq([])
      end

      it 'is only shows given interlocutor messages' do
        login_as(@consumer)
        get api_v1_message_path(@expert2.id), nil

        expect(response.status).to eq 200
        expect(response_json).to eq([])
      end

      it 'lists expert messages' do
        login_as(@expert)
        get api_v1_message_path(@consumer.id), nil

        expect(response.status).to eq 200
        expect(response_json).to eq([
         {"incoming"=>false, "read"=>true,  "date"=>1413234444, "message"=>"Ready, let`s roll" },
         {"incoming"=>false, "read"=>true,  "date"=>1413234333, "message"=>"Hello back" },
         {"incoming"=>true,  "read"=>false, "date"=>1413234222, "message"=>"Hi" },
         {"incoming"=>false, "read"=>true,  "date"=>1413234111, "message"=>"Hello" },
         {"incoming"=>true,  "read"=>false, "date"=>1413234000, "message"=>"Hi" }
        ])
      end

      it 'next time messages are marked as read' do
        login_as(@consumer)
        get api_v1_message_path(@expert.id), nil
        get api_v1_message_path(@expert.id), nil

        response_json.
          select { |message| message['incoming'] }.
          each do |incoming|
            expect(incoming['read']).to eq true
          end
      end
    end

    context 'lots of messages' do
      # TODO pagination

    end
  end
end
