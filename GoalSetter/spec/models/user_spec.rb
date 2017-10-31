# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'byebug'
require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) do
    create_user
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }

    it 'create a password digest when password is given' do
      expect(user.password_digest).to_not be nil
    end

    it 'creates a session token before validation' do
      user.valid?
      expect(user.session_token).to_not be nil
    end
  end

  describe 'associations' do
    it { should have_many(:goals) }
    it { should have_many(:comments) }
  end

  describe '#password=' do
    it 'should check if password is stored in the database' do
      user.valid?
      expect(User.find_by(username: "trung").password).to be_nil
    end

    it 'should generate a password_digest when password is given' do
      expect(user.password_digest).to_not be nil
    end
  end

  describe '#ensure_session_token' do
    it "should create a session_token after user is creates" do
      expect(user.session_token).to_not be nil
    end
  end

  describe '#reset_session_token' do
    it 'should reset user session_token' do
      expect(user.session_token).to_not eq(user.reset_session_token)
    end

    it "should save a new session_token" do
      expect(user.reset_session_token).to eq(user.session_token)
    end
  end

  describe '::find_by_credentials' do
    before { user.save }

    it "returns user if passed in good credentials" do
      expect(User.find_by_credentials("trung", "password")).to eq(user)
    end

    it "returns nil if given bad credentials" do
      expect(User.find_by_credentials("trung", "other_password")).to be nil
    end
  end

  describe '#valid_password?' do
    it "should verify the password_digest is the right password" do
      expect(user.valid_password?('password')).to be true
    end

    it "should verify password_digest is wrong for the wrong password" do
      expect(user.valid_password?('other_password')).to be false
    end
  end
end
