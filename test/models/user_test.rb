require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'rahul', email: 'rahul@g.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 251
    assert_not @user.valid?
  end

  test 'valid email should be accepted' do
    valid_emails = %w[p@g.com x.v@g.com ert5@ty.ty]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?
    end
  end

  test 'invalid email should be rejected' do
    invalid_emails = %w[x.v @g.com er-.@t5@ty.ty]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be valid"
    end
  end

  test 'password should have minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'email should be case insensitive' do
    email = 'ABCD@g.com'
    @user.email = email.downcase
    assert @user.valid?
  end
end
