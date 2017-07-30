require 'rails_helper'


describe Authenticable, type: :controller do

  # Controller anonimo Rspec
  controller (ApplicationController) do
    include Authenticable
  end

  # melhor legibilidade (envelopa o subject utilizando
  # um nome que diga algo mais do que subject)
  let(:app_controller) { subject }

  # OU
  # subject.mehod

  describe '#current_user' do
    let(:user) { create(:user) }

    before do
      # Mock
      # Objeto double + retorno que espero na chamada de headers (user.auth_token)
      req = double(headers: { 'Authorization' => user.auth_token})

      # Stub
      # Meu app_controller tem um metódo chamado request
      # que retorno exatamente um objeto igual req
      allow(app_controller).to receive(:request).and_return(req)
    end


    it 'returns user from authorization header' do
      expect(app_controller.current_user).to eq(user)
    end

  end

  describe '#authenticate_with_token' do

    # Controller anonimo Rspec
    controller do
      before_action :authenticate_with_token!
      def restricted_action; end
    end


    context 'when there is no user logged in'  do
      before do
        allow(app_controller).to receive(:current_user).and_return(nil)
        routes.draw { get 'restricted_action' => 'anonymous#restricted_action' }
        get :restricted_action
      end

      it 'return status 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'return json data for errors' do
        expect(json_body).to have_key(:errors)
      end

    end

  end

  describe 'user_logged_in?' do

    context 'when there is a user logged in' do
      before do
        user = create(:user)
        allow(app_controller).to receive(:current_user).and_return(user)
      end

      it { expect(app_controller.user_logged_in?).to be true }
    end

    context 'when there is not a user logged ind' do
      before do
        allow(app_controller).to receive(:current_user).and_return(nil)
      end

      it { expect(app_controller.user_logged_in?).to be false }
    end

  end

end
