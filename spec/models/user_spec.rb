require 'rails_helper'

describe User, type: [:model, :user]  do
  subject { build(:user) }

  context "when user is created" do

    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_uniqueness_of(:email).case_insensitive }
    it { expect(subject).to validate_confirmation_of(:password) }
    it { expect(subject).to allow_value("toni.esteves@gmail.com").for(:email) }

  end


end
