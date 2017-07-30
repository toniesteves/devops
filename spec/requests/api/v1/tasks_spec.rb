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

  describe 'GET /tasks' do
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

  describe 'GET /tasks/:id' do
    let!(:task) { create(:task, user_id: user.id) }
    before do
      get "/tasks/#{task.id}", params: { }, headers: headers
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'return json with task' do
      expect(json_body[:title]).to eq(task.title)
    end

  end

  describe 'POST /tasks' do

    before do
      post '/tasks', params: { task: task_params }.to_json, headers: headers
    end

    context 'when parameters are valid' do
      let(:task_params) { attributes_for(:task) }

      it 'return status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'return json to created task' do
        expect(json_body[:title]).to eq(task_params[:title])
      end

      it 'save task in database' do
        expect( Task.find_by(title: task_params[:title])).not_to be_nil

        # Outra forma
        # expect( Task.find_by(title: task_params[:title].count).to eq(1) )
      end

      it 'assings created task to current user' do
        expect(json_body[:user_id]).to eq(user.id)
      end

    end

    context 'whe parameters are invalid' do
      let(:task_params) { attributes_for(:task, title: ' ') }

      it 'return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not saved in database' do
        expect( Task.find_by(title: task_params[:title])).to be_nil
      end

      it 'return json error for title' do
        expect(json_body[:errors]).to have_key(:title)
      end

    end
  end
end
