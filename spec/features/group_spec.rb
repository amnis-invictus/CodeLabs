require 'rails_helper'

RSpec.describe 'Group', type: :feature, ui: true do
  let(:groups_path) { '/en/groups' }
  let(:group_last_path) { "/en/groups/#{ Group.last.id }" }
  let(:new_groups_path) { '/en/groups/new' }

  describe 'as a standard user' do
    let(:user) { create :user }

    before { perform_login user.email, user.password }
    before { visit groups_path }

    it('cannot see create group link') { expect(page).to have_no_link('Create a new group') }

    context 'with public group' do
      let(:group) { create :group }

      before { visit "#{ groups_path }/#{ group.id }" }

      it 'can open group page' do
        expect(page).to have_text(group[:name])
        expect(page).to have_text('You are not a group member')
      end

      it 'can join public group' do
        click_button 'commit'
        expect(page).to have_no_text('You are not a group member')
        expect(page).to have_link('Group submissions')
      end
    end

    context 'with moderated group' do
      let(:group) { create :group, :moderated }

      context 'without confirmed membership' do
        before { visit "#{ groups_path }/#{ group.id }" }

        it 'can open group page' do
          expect(page).to have_text(group[:name])
          expect(page).to have_text('You are not a group member')
          expect(page).to have_no_link('Group submissions')
        end

        it 'can send join request' do
          click_button 'commit'
          expect(page).to have_text('Participation request has been sent')
          expect(page).to have_no_link('Group submissions')
        end
      end

      context 'with confirmed membership' do
        before { create :membership, :for_group, membershipable: group, user: user, state: :accepted, role: :user }
        before { visit "#{ groups_path }/#{ group.id }" }

        it 'can see group details' do
          expect(page).to have_text(group[:name])
          expect(page).to have_no_text('You are not a group member')
          expect(page).to have_link('Group submissions')
        end
      end
    end
  end

  describe 'as a confirmed user' do
    let(:user) { create :user, :confirmed }

    before { perform_login user.email, user.password }
    before { visit groups_path }

    it('can see create group link') { expect(page).to have_link('Create a new group') }

    context 'with private group' do
      let(:group) { attributes_for :group, :private }

      it 'can create group' do
        visit new_groups_path
        fill_inputs 'group', group.slice(:name, :description)
        fill_selects 'group', group.slice(:visibility)
        click_button 'commit'

        expect(page).to have_current_path(group_last_path)
        expect(page).to have_text(group[:name])
        expect(page).to have_text(group[:description])
        expect(page).to have_text('Only group owners can add users')
      end
    end
  end

  describe 'as a group owner' do
    let(:user) { create :user, :confirmed }

    before { create :membership, :for_group, membershipable: group, user: user, state: :accepted, role: :owner }
    before { perform_login user.email, user.password }
    before { visit groups_path }

    context 'with moderated group' do
      let(:group) { create :group, :moderated }

      context 'with pending join request' do
        let(:member) { create :user, name: 'John Doe Member' }
        let! :membership do
          create :membership, :for_group, membershipable: group, user: member, state: :requested, role: :user
        end

        it 'can accept pending join request' do
          visit "#{ groups_path }/#{ group.id }/group_memberships"
          expect(page).to have_text(member.name)
          expect do
            click_link 'accept'
            expect(page).to have_no_text(member.name)
          end.to change { membership.reload.state }.from('requested').to('accepted')
        end
      end
    end
  end

  describe 'moderated group join flow' do
    let(:owner) { create :user, :confirmed }
    let(:member) { create :user }
    let(:group_attributes) { attributes_for :group, :moderated }

    it do
      perform_login owner.email, owner.password
      visit groups_path
      click_link 'Create a new group'
      expect(page).to have_current_path(new_groups_path)
      fill_inputs 'group', group_attributes.slice(:name, :description)
      fill_selects 'group', group_attributes.slice(:visibility)
      expect do
        click_button 'commit'
        expect(page).to have_current_path(group_last_path)
      end.to change { Group.count }.from(0).to(1)
      click_link 'Sign out'

      perform_login member.email, member.password
      visit groups_path
      expect(page).to have_text(group_attributes[:name])
      click_link group_attributes[:name]
      expect(page).to have_text('You are not a group member')
      expect do
        click_button 'commit'
        expect(page).to have_text('Participation request has been sent')
      end.to change { Membership.count }.from(1).to(2)
      expect(page).to have_no_link('Group submissions')
      click_link 'Sign out'

      perform_login owner.email, owner.password
      visit "#{ group_last_path }/group_memberships"
      expect(page).to have_text(member.name)
      expect do
        click_link 'accept'
        expect(page).to have_no_text(member.name)
      end.to change { Membership.last.state }.from('requested').to('accepted')
      click_link 'Sign out'

      perform_login member.email, member.password
      visit group_last_path
      expect(page).to have_text(group_attributes[:description])
      expect(page).to have_link('Group submissions')
    end
  end
end
