require 'rails_helper'

RSpec.describe 'Group', type: :feature, ui: true do
  let(:groups_path) { '/en/groups' }
  let(:group_last_path) { "/en/groups/#{ Group.last.id }" }
  let(:new_groups_path) { '/en/groups/new' }

  describe 'as a standard user' do
    let(:user) { create :user }

    before { perform_login user.email, user.password }
    before { visit groups_path }

    context 'can\'t see create group link' do
      it { expect(page).to have_no_link('Create a new group') }
    end

    context 'can open public group' do
      let(:group) { create :group }

      before { visit "#{ groups_path }/#{ group.id }" }

      it { expect(page).to have_text(group[:name]) }
      it { expect(page).to have_text('You are not a group member') }

      context 'can join public group' do
        before { click_button 'commit' }

        it { expect(page).to have_no_text('You are not a group member') }
        it { expect(page).to have_link('Group submissions') }
      end
    end

    context 'can open moderated group' do
      let(:group) { create :group, :moderated }

      before { visit "#{ groups_path }/#{ group.id }" }

      it { expect(page).to have_text(group[:name]) }
      it { expect(page).to have_text('You are not a group member') }

      context 'can send join request to moderated group' do
        before { click_button 'commit' }

        it { expect(page).to have_text('Participation request has been sent') }
        it { expect(page).to have_no_link('Group submissions') }

        context 'asd' do
          let(:user_confirmed) { create :user, :admin }
          before { create :membership, :for_group }

          before { click_link 'Sign out' }
          before { perform_login user_confirmed.email, user_confirmed.password }
          before { visit "#{ groups_path }/#{ group.id }"; sleep 50 }

          it { expect(page).to have_link('Group submissions') }
        end
      end
    end

    context 'can open public group' do
      let(:group) { create :group }

      before { visit "#{ groups_path }/#{ group.id }" }

      it { expect(page).to have_text(group[:name]) }
      it { expect(page).to have_text('You are not a group member') }

      context 'can json public group' do
        before { click_button 'commit' }

        it { expect(page).to have_no_text('You are not a group member') }
        it { expect(page).to have_link('Group submissions') }
      end
    end
  end

  describe 'as a confirmed user' do
    let(:user) { create :user, :confirmed }

    before { perform_login user.email, user.password }
    before { visit groups_path }

    context 'can see create group link' do
      it { expect(page).to have_link('Create a new group') }
    end

    context 'can create group' do
      let(:group) { attributes_for :group }

      before { visit new_groups_path }

      before do
        fill_inputs 'group', group.slice(:name, :description)
        fill_selects 'group', group.slice(:visibility)
      end

      before { click_button 'commit' }

      it('redirect to group page') { expect(page).to have_current_path(group_last_path) }

      it { expect(page).to have_text(group[:name]) }
      it { expect(page).to have_text(group[:description]) }
      # <i class="mr-3 fas fa-unlock" title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Public"></i>
      # it { expect(page).to have_text('group_city', with: group[:visibility]) }
    end
  end
end
