require 'rails_helper'

RSpec.describe Api::V1::ProfilesController do
  TwitterUser = Struct.new(:id, :name, :description, :screen_name, :profile_image_url_base, :profile_banner_url) do
    def profile_image_url format = nil
      profile_image_url_base
    end
  end

  context '#create' do
    context 'incorrect' do
    # TODO: some kind of ProfileCreatorError
    # it 'refuses to create user with no token' do
    #   post api_v1_profile_path, secret: 'secret'
    #   expect(response.status).to eq 400
    # end

    # it 'refuses to create user with no token secret' do
    #   post api_v1_profile_path, token: '123'
    #   expect(response.status).to eq 400
    # end

    # it 'refuses to create user if twitter returns an error' do
    #   post api_v1_profile_path, token: '123', secret: 'secret'
    #   expect(response.status).to eq 400
    # end
    end

    context 'correct' do
      before do
        allow_any_instance_of(TwitterTalker).to receive(:user).
          and_return(TwitterUser.new(
            'twitter_id',
            'John Smith',
            'Blah blah',
            'screen_name',
            'http://profile_image_url.com',
            'http://profile_banner_url.com'
          )
        )
      end

      it 'does not create duplicated user on same twitter id' do
        old_user = create :user, twitter_id: 'twitter_id'
        post api_v1_profile_path, token: '123', secret: 'secret'
        expect(response.status).to eq 201
        user = User.find_by(access_token: response_json['token'])
        expect(user).to eq old_user
      end

      it 'creates a user given a token and a secret' do
        post api_v1_profile_path, token: '123', secret: 'secret'
        expect(response.status).to eq 201
        user = User.find_by(access_token: response_json['token'])
        expect(user.full_name).to eq 'John Smith'
        expect(user.about).to eq 'Blah blah'
        expect(user.twitter_id).to eq 'twitter_id'
        expect(user.twitter_token).to eq '123'
        expect(user.twitter_token_secret).to eq 'secret'
        expect(user.twitter_url).to eq 'https://twitter.com/screen_name'
        # expect(user.profile_image_url).to eq 'http://profile_image_url.com'
        # expect(user.profile_banner_url).to eq 'http://profile_banner_url.com'
      end
    end
  end

#   context 'without a token' do
#     it '' do
#       get api_v1_profile_path
#       # put api_v1_profile_path
#       it_behaves_like 'token protected resource'
#     end
#   end
 
  context 'with access token' do
    let(:user) { create :user }

    it '#show' do
      login_as(user)
      get api_v1_profile_path, nil

      expect(response.status).to eq 200
      expect(response_json.symbolize_keys).to eq({
        about: user.about,
        email: user.email,
        full_name: user.full_name,
        id: user.id,
        job: user.job,
        photo_url: user.photo_url(:small),
        profile_banner_url: user.profile_banner.url(:normal),
        slug: user.slug,
        behance_url: user.behance_url,
        github_url: user.github_url,
        linkedin_url: user.linkedin_url,
        stackoverflow_url: user.stackoverflow_url,
        twitter_url: user.twitter_url,
        website_url: user.website_url
      })
    end

    it 'updates allowed parameters' do
      VARIABLE_PROPERTIES = [:about, :full_name, :job]
      URLS = [:behance_url, :github_url, :linkedin_url, :stackoverflow_url, :website_url]
      RESTRICTED_PROPERTIES = [:id, :slug, :twitter_id, :twitter_token, :twitter_token_secret, :twitter_url]
      # TODO: those are rounded on persistence :created_at, :updated_at]
      login_as(user)
      put api_v1_profile_path,
        (VARIABLE_PROPERTIES + URLS).product(['changed']).to_h.merge(RESTRICTED_PROPERTIES.product(['pwn']).to_h).merge(email: 'changed@change.org')
      expect(response.status).to eq 201
      after = user.clone
      after.reload
      VARIABLE_PROPERTIES.each do |property|
        expect(after.send(property)).to eq 'changed'
      end
      URLS.each do |url|
        expect(after.send(url)).to eq 'http://changed'
      end
      expect(after.email).to eq 'changed@change.org'
      RESTRICTED_PROPERTIES.each do |property|
        expect(after.send(property)).to eq user.send(property)
      end
    end

    it 'updates push token' do
      login_as(user)
      token = SecureRandom.hex
      post pushtoken_api_v1_profile_path, { ios_device_token: token }

      expect(response.status).to eq 202
      expect(response.body).to be_blank

      expect(user.reload.ios_device_token).to eq token
    end

    it 'updates location' do
      login_as(user)
      latitude, longitude = rand(0..100), rand(0..100)
      post location_api_v1_profile_path, { latitude: latitude, longitude: longitude }

      expect(response.status).to eq 200
      expect(response.body).to be_blank

      expect(user.reload.latitude).to eq latitude
      expect(user.reload.longitude).to eq longitude
    end
  end
end
