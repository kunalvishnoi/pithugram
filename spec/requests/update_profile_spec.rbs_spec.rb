require 'rails_helper'

RSpec.describe 'UpdateProfileSpec.rbs', type: :request do
  describe 'user should exist' do
    let(:user) { User.create(name: 'foobar', email: 'foo@foobar.com', password: 'foobar', password_confirmation: 'foobar') }
    before do
      log_in user
    end
    describe 'visit the edit profile path' do
      before { visit edit_user_path(user) }

      describe 'Update should be successful' do
        let(:new_name) { 'foo' }
        let(:new_email) { 'foobar@foo.com' }
        before do
          fill_in 'Name', with: new_name
          fill_in 'Email', with: new_email
          fill_in 'Password', with: user.password
          fill_in 'Confirmation', with: user.password_confirmation
          click_button 'Save Changes'
        end

        it { expect(user.reload.name).to eq new_name }
        it { expect(user.reload.email).to eq new_email }
      end
    end
  end
end
