require 'rails_helper'

describe Task, type: :model do

  subject { build(:task) }

  context 'When is new' do
    # RSpec sabe que existe o campo booleano 'done' na classe task
    # e por sua vez cria o match dinamico 'be_done'
    it { expect(subject).not_to be_done }
  end

  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :user_id }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:deadline) }
  it { is_expected.to respond_to(:user_id) }
end
