require 'rails_helper'

RSpec.describe 'Profile', type: :feature, ui: true do
  describe 'for a standard user' do
    let(:user) { create :user }

    before { perform_login user.email, user.password }

    it { expect(page).to have_field('user_name', with: user.name) }
    it { expect(page).to have_field('user_username', with: user.username) }
    it { expect(page).to have_field('user_city', with: user.city) }
    it { expect(page).to have_field('user_institution', with: user.institution) }
    it { expect(page).to have_link('Ask for confirmation') }
    it { expect(page).to have_no_link('Workers', visible: :all) }
  end

  describe 'for an admin user' do
    let(:user) { create :user, :admin }

    before { perform_login user.email, user.password }

    it { expect(page).to have_field('user_name', with: user.name) }
    it { expect(page).to have_field('user_username', with: user.username) }
    it { expect(page).to have_no_link('Ask for confirmation') }
    it { expect(page).to have_link('Workers', visible: :all) }
  end
end
