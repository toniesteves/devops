require 'rails_helper'

describe Api::V1::ApplicationController, type: :controller  do

  describe 'include correct concerns' do
    it { expect(controller.class.ancestors).to include(Authenticable) }
  end

end
