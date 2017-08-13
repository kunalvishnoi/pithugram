require 'spec_helper'

describe User do
  before do
    @user = User.create(name: 'foobars', email: 'foobars@gmail.com',
                        password: 'foobar', password_confirmation: 'foobar')
  end

  subject { @user }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to :password_confirmation }
  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:authenticate) }

  describe 'when name is not present' do
    before { @user.name = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'when email is not present' do
    before { @user.email = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'when name is too long' do
    before { @user.name = 'a' * 55 }
    it { is_expected.not_to be_valid }
  end

  describe 'when invalid email is used' do
    it 'should not be valid' do
      addresses = %w[foobar@ foo.com foob@invalid_email.co @go.c foo@.c]
      addresses.each do |address|
        @user.email = address
        expect(@user).not_to be_valid
      end
    end
  end

  describe 'when valid emails are used' do
    it 'should be valid' do
      addresses = %w[foo@g.com foo_bar@g.com]
      addresses.each do |address|
        @user.email = address
        expect(@user).not_to be_valid
      end
    end
  end

  xdescribe 'when email address is already taken' do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe 'when password is not present' do
    before do
      @user = User.new(name: 'Example User', email: 'user@example.com',
                       password: ' ', password_confirmation: ' ')
    end
    it { is_expected.not_to be_valid }
  end

  describe 'when password confirmation doesnt match' do
    before do
      @user.password_confirmation = 'mismatch'
    end

    it { is_expected.not_to be_valid }
  end

  describe 'password length' do
    it 'when password length is too short' do
      @user.password_confirmation = @user.password = 'a' * 3
      expect(@user).not_to be_valid
    end

    it 'when password length is acceptable' do
      @user.password_confirmation = @user.password = 'a' * 7
      expect(@user).to be_valid
    end
  end

  describe 'return authentication' do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe 'with valid password' do
      it { is_expected.to eq found_user.authenticate(@user.password) }
    end

    describe 'with invalid password' do
      let(:invalid_email) { found_user.authenticate('invalid') }
      it { is_expected.not_to eq invalid_email }
    end
  end
end
