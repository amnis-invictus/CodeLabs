require 'rails_helper'

RSpec.describe TagTranslation, type: :model do
  it { should validate_presence_of :language }

  it { should validate_presence_of :name }

  it { should belong_to :tag }

  it { should define_enum_for(:language).with(I18n.available_locales) }
end
