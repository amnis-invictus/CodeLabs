require 'rails_helper'

RSpec.describe 'Login', type: :feature, ui: true do
  let(:login_path) { '/en/session/new' }
  let(:profile_path) { '/en/profile' }

  before { visit login_path }

  describe 'as a standard user' do
    before { create :user }

    before do
      fill_inputs 'session', params.slice(:email, :password)
    end

    context 'with everything valid' do
      let(:params) { attributes_for :user }

      before { click_button 'commit' }

      it('redirect to profile page') { expect(page).to have_current_path(profile_path) }
    end
  end
end
