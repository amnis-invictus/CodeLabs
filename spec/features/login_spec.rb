require 'rails_helper'

RSpec.describe 'Login', type: :feature, ui: true do
  let(:login_path) { '/en/session/new' }
  let(:profile_path) { '/en/profile' }

  before { visit login_path }

  describe 'as a standard user' do
    let(:user) { create :user }

    before do
      fill_inputs 'session', params.slice(:email, :password)
    end

    context 'with everything valid' do
      let(:params) { { email: user.email, password: user.password } }

      before { click_button 'commit' }

      it('redirect to profile page') { expect(page).to have_current_path(profile_path) }
    end

    context 'with wrong email' do
      let(:params) { attributes_for :user, email: 'judy.doe@codelabs.test' }

      before { click_button 'commit' }

      it('redirect to login page') { expect(page).to have_current_path(login_path) }
      it { expect(page).to have_text('Email is invalid') }
    end

    context 'with wrong password' do
      let(:params) { { email: user.email, password: SecureRandom.base36 } }

      before { click_button 'commit' }

      it('redirect to login page') { expect(page).to have_current_path(login_path) }
      it { expect(page).to have_text('Password is invalid') }
    end
  end

  describe 'as an admin user' do
    let(:admin_user) { create :user, :admin }

    before do
      fill_inputs 'session', params.slice(:email, :password)
    end

    context 'with everything valid' do
      let(:params) { { email: admin_user.email, password: admin_user.password } }

      before { click_button 'commit' }

      it('redirect to profile page') { expect(page).to have_current_path(profile_path) }
    end
  end
end
