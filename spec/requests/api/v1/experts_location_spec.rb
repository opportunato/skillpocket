require 'rails_helper'

RSpec.describe Api::V1::ExpertsController do
  let(:user)      { create :user, max_search_distance: distance, latitude: latitude, longitude: longitude }
  let!(:outlander) { create :skilled_user, latitude: 33, longitude: -117 }
  let!(:center)    { create :skilled_user, latitude: 32.751066, longitude: -117.079155 }
  let!(:coast)     { create :skilled_user, latitude: 32.758573, longitude: -117.203094 }
  let!(:south)     { create :skilled_user, latitude: 32.612361, longitude: -117.059929 }
  let!(:unknown1)  { create :skilled_user }
  let!(:unknown2)  { create :skilled_user }
  # We have a couple of experts. Let's check that depending on our location and max distance settings we filter some of them out

  context 'user is in center' do
    let(:latitude)  { 32.721031 }
    let(:longitude) { -117.157776 }

    context 'when distance is huge' do
      let(:distance)  { 60 }
      it 'shows all of them' do
        get api_v1_experts_path, nil, as(user)
        expect(response_json.size).to eq 4
        expect(response_json.map {|expert| expert['id'] }.sort).to eq [outlander, center, coast, south].map(&:id).sort
      end
    end

    context 'with small distance' do
      let(:distance)  { 6 }
      it 'shows closest' do
        get api_v1_experts_path, nil, as(user)
        expect(response_json.size).to eq 2
        expect(response_json.map {|expert| expert['id'] }.sort).to eq [center, coast].map(&:id).sort
      end
    end
  end

  context 'user location is unknown' do
    let(:latitude)  { nil }
    let(:longitude) { nil }
    let(:distance)  { 0 }
    it 'shows no experts' do
      get api_v1_experts_path, nil, as(user)
      expect(response_json.size).to eq 0
    end
  end

  describe do
    let(:latitude)  { 32.721031 }
    let(:longitude) { -117.157776 }
    let(:distance)  { 6 }
    it 'we get distance to experts in km' do
      get api_v1_experts_path, nil, as(user)
      expect(response_json.map {|expert| expert['distance'] }.sort).to eq [3.6966070831728657, 5.018556296161502]
    end
  end
end
