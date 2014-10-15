require 'rails_helper'

RSpec.describe Api::V1::ContactsController do
  # it_behaves_like 'token protected resource'

  describe 'list' do
    before(:all) do
      @consumer = create :user
      one = create :skilled_user
      two = create :skilled_user
      Timecop.freeze(Time.at(1234567000)) { one.send_message_to @consumer, 'hey' }
      Timecop.freeze(Time.at(1234568000)) { two.send_message_to @consumer, 'whatup' }
    end

    it 'lists customers messages' do
      get api_v1_contacts_path, nil, authorization: ActionController::HttpAuthentication::Token.encode_credentials(@consumer.access_token)

      expect(response.status).to eq 200
      expect(response_json.size).to eq 2
      expect(response_json).to eq([
       { "id"=>5,
         "full_name"=>"first_name 4 last_name 4",
         "about"=>"about 4",
         "unread"=>1,
         "message"=>"whatup",
         "date"=>1234568000},
       { "id"=>3,
         "full_name"=>"first_name 2 last_name 2",
         "about"=>"about 2",
         "unread"=>1,
         "message"=>"hey",
         "date"=>1234567000
       }
      ])
    end

    context 'lots of messages' do
      # TODO pagination

    end
  end
end
