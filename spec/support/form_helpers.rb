module FormHelpers
  def fill_inputs prefix, params
    within 'form' do
      params.each do |name, value|
        fill_in "#{ prefix }_#{ name }", with: value if value.present?
      end
    end
  end

  def fill_selects prefix, params
    within 'form' do
      params.each do |name, value|
        # select value, from: "#{ prefix }_#{ name }", visible: :all if value.present?
        find(".dropdown-toggle[data-id='#{ prefix }_#{ name }']").click if value.present?
        find('.dropdown-item', text: value).click if value.present?
      end
    end
  end
end
