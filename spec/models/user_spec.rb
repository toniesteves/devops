require 'rails_helper'

describe User, type: [:model, :user]  do
  before { @user = build(:user) }

  it { expect(@user).to respond_to(:email) }
  it { expect(@user).to respond_to(:name) }
  it { expect(@user).to respond_to(:password) }
  it { expect(@user).to respond_to(:password_confirmation) }
  it { expect(@user).to be_valid }


end
