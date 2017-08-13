require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  subject { page }

  describe 'GET home page' do
    before { visit root_path }
    it { is_expected.to have_content('Pithugram') }
    it { is_expected.to have_title('Pithugram') }
  end

  describe 'GET about page' do
    before { visit about_path }
    it { is_expected.to have_content('About') }
    it { is_expected.to have_title('About|Pithugram') }
  end

  describe 'GET help page' do
    before { visit help_path }

    it { is_expected.to have_content('Help') }
    it { is_expected.to have_title('Help|Pithugram') }
  end

  describe 'GET contact page' do
    before { visit contact_path }

    it { is_expected.to have_content('Contact') }
    it { is_expected.to have_title('Contact|Pithugram') }
  end
end
