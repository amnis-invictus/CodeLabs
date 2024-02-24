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
        next if value.blank?

        find(".dropdown-toggle[data-id='#{ prefix }_#{ name }']").click
        find('.dropdown-item', text: value).click
      end
    end
  end
end
