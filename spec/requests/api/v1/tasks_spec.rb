require 'rails_helper'

describe 'Tasks API', type: [:request, :task]  do

  before { host! 'api.task-manager.dev' }

  let!(:user) { create(:user) }
  let(:headers) do
    {
      'Accept' => 'application/vnd.taskmanager.v1',
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => user.auth_token

    }
  end

  describe "GET /tasks" do
    before do
      create_list(:task, 5, user_id: user.id)
      get '/tasks', params: {}, headers: headers
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'return 5 tasks from database' do
      expect(json_body[:tasks].count).to eq(5)
    end

  end



end
