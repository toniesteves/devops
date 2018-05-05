require 'rails_helper'

describe 'Tasks API', type: [:request, :task]  do

  before { host! 'localhost' }

  let!(:user) { create(:user) }
  let(:headers) do
    {
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => user.auth_token

    }
  end

  describe 'GET /api/v1/tasks' do
    before do
      create_list(:task, 5, user_id: user.id)
      get '/api/v1/tasks', params: {}, headers: headers
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'return 5 tasks from database' do
      expect(json_body[:tasks].count).to eq(5)
    end

  end

  describe 'GET /api/v1/tasks/:id' do
    let!(:task) { create(:task, user_id: user.id) }
    before do
      get "/api/v1/tasks/#{task.id}", params: { }, headers: headers
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'return json with task' do
      expect(json_body[:title]).to eq(task.title)
    end

  end

  describe 'POST /api/v1/tasks' do

    before do
      post '/api/v1/tasks', params: { task: task_params }.to_json, headers: headers
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

  describe 'PUT /api/v1/task/:id' do
    let!(:task) { create(:task, user_id: user.id) }

    before do
      put "/api/v1/tasks/#{task.id}", params: { task: task_params }.to_json, headers: headers
    end

    context "when are valid params" do
      let(:task_params) { attributes_for(:task, title: 'New task title') }

      it 'return status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'return json for updated task' do
        expect(json_body[:title]).to eq(task_params[:title])
      end

      it 'update task in database' do
        expect( Task.find_by(title: task_params[:title]) ).not_to be_nil
      end


    end

    context "when are invalid params" do
      let(:task_params) { attributes_for(:task, title: ' ') }

      it 'return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return json error for title' do
        expect(json_body[:errors]).to have_key(:title)
      end

      it 'task does not updated in database' do
        expect( Task.find_by(title: task_params[:title]) ).to be_nil
      end

    end
  end

  describe 'DELETE /api/v1/task/:id' do
    let!(:task) { create(:task, user_id: user.id) }

    before do
      delete "/api/v1/tasks/#{task.id}", params: { }, headers: headers
    end

    it 'return http status 204' do
      expect(response).to have_http_status(:no_content)
    end

    it 'remove task from database' do
      expect { Task.find(task.id) }.to raise_error(ActiveRecord::RecordNotFound)
      # Outra forma
      # expect (Task.find_by(task.id)).to be_nil
    end

  end
end
