require 'rails_helper'

describe 'Users API', type: [:request, :user]  do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }

  before { host! 'api.task-manager.dev' }

  describe "GET /users/:id " do

    before do
      headers = {"Accept" => "application/vnd.taskmanager.v1"}
      get "/users/#{user_id}", params:{}, headers: headers
    end


    context "when the user exists" do
      it "returns the user" do
        response_body = JSON.parse(response.body)
        expect(response_body["id"]).to eq(user_id)
      end

      it "return 200 status code" do
        expect(response).to have_http_status(:ok)
      end

    end

    context "when the user doesnt exists" do
      let(:user_id) { 1001 }

      it "return 404 status code" do
        expect(response).to have_http_status(:not_found)
      end

    end

  end

end
