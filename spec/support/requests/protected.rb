RSpec.shared_examples 'token protected resource' do
  context 'without a token' do
    it { expect(response.status).to eq 401 }
  end
end
