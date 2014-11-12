require 'rails_helper'

RSpec.describe TwitterFriendsSyncer do
  before :each do
    @user = create(:user)
    @first_expert = create(:skilled_user, { twitter_id: "4", approved: true })
    @second_expert = create(:skilled_user, { twitter_id: "5", approved: true })
    @third_expert = create(:skilled_user, { twitter_id: "23", approved: true })

    twitter_talker = instance_double("TwitterTalker")
    first_expert_twitter_talker = instance_double("TwitterTalker")
    second_expert_twitter_talker = instance_double("TwitterTalker")
    third_expert_twitter_talker = instance_double("TwitterTalker")
    user_data = instance_double("Twitter::User")

    allow(twitter_talker).to receive(:friend_ids).with(user_id: @user.twitter_id) { [4,8,15,16,23,42] }
    allow(first_expert_twitter_talker).to receive(:follower_ids).with(user_id: @first_expert.twitter_id).and_return([8, 15, 11])
    allow(second_expert_twitter_talker).to receive(:follower_ids).with(user_id: @second_expert.twitter_id).and_return([1300, 1400, 1500])
    allow(third_expert_twitter_talker).to receive(:follower_ids).with(user_id: @third_expert.twitter_id).and_return([42, 9, 7])
    allow(twitter_talker).to receive(:user) { user_data }
    allow(first_expert_twitter_talker).to receive(:user) { user_data }
    allow(second_expert_twitter_talker).to receive(:user) { user_data }
    allow(third_expert_twitter_talker).to receive(:user) { user_data }
    allow(user_data).to receive(:followers_count) { 400 }
    allow(user_data).to receive(:friends_count) { 400 }

    allow(TwitterTalker).to receive(:new).with(@user.twitter_token, @user.twitter_token_secret) { twitter_talker }
    allow(TwitterTalker).to receive(:new).with(@first_expert.twitter_token, @first_expert.twitter_token_secret) { first_expert_twitter_talker } 
    allow(TwitterTalker).to receive(:new).with(@second_expert.twitter_token, @second_expert.twitter_token_secret) { second_expert_twitter_talker } 
    allow(TwitterTalker).to receive(:new).with(@third_expert.twitter_token, @third_expert.twitter_token_secret) { third_expert_twitter_talker }   
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

  it 'correctly sets friended followers of first expert' do
    TwitterFriendsSyncer.new([@user]).sync
    expect(UserFriendedExpertFollower.where(user_id: @user.id, expert_id: @first_expert.id).pluck(:twitter_id)).to eq(["15", "8"])
  end

  it 'correctly sets friended followers of second expert' do
    TwitterFriendsSyncer.new([@user]).sync
    expect(UserFriendedExpertFollower.where(user_id: @user.id, expert_id: @second_expert.id).pluck(:twitter_id)).to eq([])
  end

  it 'correctly sets friended followers of third expert' do
    TwitterFriendsSyncer.new([@user]).sync
    expect(UserFriendedExpertFollower.where(user_id: @user.id, expert_id: @third_expert.id).pluck(:twitter_id)).to eq(["42"])
  end
end