require 'rails_helper'

RSpec.describe TwitterFriendsSyncer do
  before :each do
    @user = create(:user)
    @first_expert = create(:skilled_user, { twitter_id: 4 })
    @second_expert = create(:skilled_user, { twitter_id: 5 })
    @third_expert = create(:skilled_user, { twitter_id: 23 })

    twitter_talker = instance_double("TwitterTalker")
    allow(twitter_talker).to receive(:friend_ids).with(user_id: @user.twitter_id) { [4,8,15,16,23,42] }

    allow(TwitterTalker).to receive(:new).with(@user.twitter_token, @user.twitter_token_secret) { twitter_talker }
  end

  it 'correctly creates new friended experts for user' do
    expect {
      TwitterFriendsSyncer.new([@user]).sync
    }.to change{ UserFriendedExpert.count }.by(2)
  end

  it 'correctly sets user id of new friended experts' do
    TwitterFriendsSyncer.new([@user]).sync
    expect(UserFriendedExpert.last.user_id).to eq(@user.id)
  end

  it 'correctly sets expert id of new friended experts' do
    TwitterFriendsSyncer.new([@user]).sync
    expect(UserFriendedExpert.where(user_id: @user.id).pluck(:expert_id)).to eq([@first_expert.id, @third_expert.id])
  end
end