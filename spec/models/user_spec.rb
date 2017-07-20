require 'rails_helper'

describe User, type: [:model, :user]  do
  subject { build(:user) }

  context "when user is created" do

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value('toni.esteves@gmail.com').for(:email) }
    it { is_expected.to validate_uniqueness_of(:auth_token)}


    describe '#info' do
      it 'returns email, created_at and a token' do
        subject.save!

        #Mock
        allow(Devise).to receive(:friendly_token).and_return('abc123xyztoken')

        expect(subject.info).to eq("#{subject.email} - #{subject.created_at} - Token: abc123xyztoken")
      end
    end

    describe '#generate_authentication_token!' do

      it 'generate a uniquene auth token' do
        allow(Devise).to receive(:friendly_token).and_return('abc123xyztoken')
        subject.generate_authentication_token!

        expect(subject.auth_token).to eq('abc123xyztoken')
      end

      it 'generate another auth token when the current auth token already has been taken' do
        allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz','abc123tokenxyz','abcXYZ123456789')
        existing_user = create(:user)
        subject.generate_authentication_token!

        expect(subject.auth_token).not_to eq(existing_user.auth_token)
      end

    end

  end


end
