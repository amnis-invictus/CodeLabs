require 'rails_helper'

RSpec.describe 'Registration', type: :feature, ui: true do
  let(:registration_path) { '/' }
  let(:login_path) { '/en/session/new' }

  before { visit registration_path }

  describe 'for standard user' do
    before do
      fill_inputs 'user', params.slice(:email, :username, :password, :password_confirmation)
    end

    context 'with everything valid' do
      let(:params) { attributes_for :user }

      before { click_button 'commit' }

      it('redirect to login page') { expect(page).to have_current_path(login_path) }
    end
  end
end
