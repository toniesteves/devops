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

end
