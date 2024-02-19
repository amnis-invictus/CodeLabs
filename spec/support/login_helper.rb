module LoginHelper
  def perform_login email, password
    visit '/en/session/new'
    fill_inputs 'session', { email: email, password: password }
    click_button 'commit'
    expect(page).to have_current_path(profile_path(I18n.locale))
  end
end
