require 'rails_helper'

RSpec.describe Api::V1::ProfilesController do
  TwitterUser = Struct.new(:id, :name, :description, :screen_name, :profile_image_url, :profile_banner_url)

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
        expect(user.first_name).to eq 'John'
        expect(user.last_name).to eq 'Smith'
        expect(user.about).to eq 'Blah blah'
        expect(user.twitter_id).to eq 'twitter_id'
        expect(user.twitter_token).to eq '123'
        expect(user.twitter_token_secret).to eq 'secret'
        expect(user.twitter_link).to eq 'https://twitter.com/screen_name'
        # expect(user.profile_image_url).to eq 'profile_image_url'
        # expect(user.profile_banner_url).to eq 'profile_banner_url'
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
      get api_v1_profile_path, nil, authorization: ActionController::HttpAuthentication::Token.encode_credentials(user.access_token)

      expect(response.status).to eq 200
      expect(response_json.symbolize_keys).to eq({
        about: user.about,
        email: user.email,
        first_name: user.first_name,
        full_name: user.full_name,
        id: user.id,
        job: user.job,
        last_name: user.last_name,
        photo_url: user.photo_url(:small),
        profile_banner_url: user.profile_banner.url(:normal),
        slug: user.slug,
        behance_link: user.behance_link,
        github_link: user.github_link,
        linkedin_link: user.linkedin_link,
        stackoverflow_link: user.stackoverflow_link,
        twitter_link: user.twitter_link,
        website_link: user.website_link
      })
    end

    it 'updates allowed parameters' do
      VARIABLE_PROPERTIES = [:about, :email, :first_name, :job, :last_name, :behance_link, :github_link, :linkedin_link, :stackoverflow_link, :twitter_link, :website_link]
      RESTRICTED_PROPERTIES = [:id, :slug, :twitter_id, :twitter_token, :twitter_token_secret]
      # TODO: those are rounded on persistence :created_at, :updated_at]
      put api_v1_profile_path,
        VARIABLE_PROPERTIES.product(['changed']).to_h.merge(RESTRICTED_PROPERTIES.product(['pwn']).to_h),
        authorization: ActionController::HttpAuthentication::Token.encode_credentials(user.access_token)
      expect(response.status).to eq 201
      after = user.clone
      after.reload
      VARIABLE_PROPERTIES.each do |property|
        expect(after.send(property)).to eq 'changed'
      end
      RESTRICTED_PROPERTIES.each do |property|
        expect(after.send(property)).to eq user.send(property)
      end
    end
  end
end
