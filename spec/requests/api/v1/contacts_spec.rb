require 'rails_helper'

RSpec.describe Api::V1::ContactsController do
  # it_behaves_like 'token protected resource'

  describe 'list' do
    before(:all) do
      @consumer = create :user
      @one = create :skilled_user
      @two = create :skilled_user
      Timecop.freeze(Time.at(1234567000)) { @one.send_message_to @consumer, 'hey' }
      Timecop.freeze(Time.at(1234568000)) { @two.send_message_to @consumer, 'whatup' }
    end

    it 'lists customers messages' do
      get api_v1_contacts_path, nil, as(@consumer)

      expect(response.status).to eq 200
      expect(response_json.size).to eq 2
      expect(response_json).to eq([{
          "id"=> @two.id,
          "full_name"=> @two.full_name,
          'photo' => @two.photo.url(:small),
          "unread"=>1,
          "text"=>'whatup',
          "time"=>1234568000
        }, {
          "id"=> @one.id,
          "full_name"=> @one.full_name,
          'photo' => @one.photo.url(:small),
          "unread"=>1,
          "text"=>'hey',
          "time"=>1234567000
        }
      ])
    end

    context 'lots of messages' do
      # TODO pagination

    end
  end
end
