require 'rails_helper'

RSpec.describe TwitterFriendsSyncer do
  before :each do
    @user = create(:user)
    @first_expert = create(:expert, { twitter_id: 4 })
    @second_expert = create(:expert, { twitter_id: 5 })
    @third_expert = create(:expert, { twitter_id: 23 })

    stub_twitter_request("/1.1/friends/ids.json")
      .with(query: {cursor: '-1', user_id: @user.twitter_id})
      .to_return(body: (<<-JSON
            {
              "previous_cursor": 0,
              "next_cursor_str": "1305102810874389703",
              "ids": [4,8,15,16],
              "previous_cursor_str": "0",
              "next_cursor": 1305102810874389703
            }
          JSON
        ), headers: {content_type: 'application/json; charset=utf-8'})
    stub_twitter_request('/1.1/friends/ids.json')
      .with(query: {cursor: '1305102810874389703', user_id: @user.twitter_id})
      .to_return(body: (<<-JSON
          {
            "previous_cursor": -1305101990888327757,
            "next_cursor_str": "0",
            "ids": [23,42],
            "previous_cursor_str": "-1305101990888327757",
            "next_cursor":0
          }
          JSON
        ), headers: {content_type: 'application/json; charset=utf-8'})    
  end

  it 'correctly creates new friended experts for user' do
    expect {
      TwitterFriendsSyncer.new.perform(@user.id)
    }.to change{ UserFriendedExpert.count }.by(2)
  end

  it 'correctly sets user id of new friended experts' do
    TwitterFriendsSyncer.new.perform(@user.id)
    expect(UserFriendedExpert.last.user_id).to eq(@user.id)
  end

  it 'correctly sets expert id of new friended experts' do
    TwitterFriendsSyncer.new.perform(@user.id)
    expect(UserFriendedExpert.where(user_id: @user.id).pluck(:expert_id)).to eq([4,23])
  end
end