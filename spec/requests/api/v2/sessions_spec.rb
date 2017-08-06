require 'rails_helper'

describe 'Sessions API', type: [:request, :session] do

  before { host! 'api.task-manager.dev' }
  let!(:user) { create(:user) }
  let(:headers) do
    {
      'Accept' => 'application/vnd.taskmanager.v2',
      'Content-Type' => Mime[:json].to_s
    }
  end

  describe 'POST /sessions' do
    before do
      post '/sessions', params: { session: credentials }.to_json, headers: headers
    end

    context 'when valid credentials' do
      let(:credentials) { { email: user.email, password: '123456' } }

      it 'return status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'return json data with user auth token' do
        user.reload
        expect(json_body[:data][:attributes][:'auth-token']).to eq(user.auth_token)
      end

    end


    context 'when invalid credentials' do
      let(:credentials) { { email: user.email, password: 'invalid_password' } }

      it 'return status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'return json data with errors' do
        user.reload
        expect(json_body).to have_key(:errors)
      end

    end

  end


  describe 'DELETE /sessions/:id' do
    let(:auth_token) { user.auth_token }

    before do
      delete "/sessions/#{auth_token}", params: {}, headers: headers
    end

    it 'return status code 204' do
      expect(response).to have_http_status(:no_content)
    end

    it 'changes de user auth token' do
      expect(User.find_by(auth_token: auth_token)).to be_nil
    end
  end
end
