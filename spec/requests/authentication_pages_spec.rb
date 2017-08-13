require 'rails_helper'

RSpec.describe 'AuthenticationPages', type: :request do
  subject { page }

  describe 'should signin' do
    before { visit login_path }

    describe 'with valid information' do
      let(:user) { User.create(name: 'foobar', email: 'abc@gmail.com', password: 'foobar', password_confirmation: 'foobar') }
      before do
        log_in user
      end
      it { is_expected.to have_link('Home', href: root_path) }
      it { is_expected.to have_link('Profile', href: user_path(user)) }
      it { is_expected.to have_link('All Users', href: users_path) }
      it { is_expected.to have_link('Update', href: edit_user_path(user)) }
      it { is_expected.to have_link('Logout', href: logout_path) }
      it { is_expected.not_to have_link('Login', href: login_path) }
    end
  end

  describe 'should logout' do
    let(:user) { User.create(name: 'foobar', email: 'abc@gmail.com', password: 'foobar', password_confirmation: 'foobar') }
    before { log_in user }
      describe ' after successful login' do
      before do
        click_link "Logout"
      end
        it { is_expected.not_to have_link('Logout', href: logout_path) }
        it { is_expected.to have_link('Home', href: root_path) }
        it { is_expected.to have_link('Login', href: login_path) }
      end
  end
end
