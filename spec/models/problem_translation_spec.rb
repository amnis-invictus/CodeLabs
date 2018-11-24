require 'rails_helper'

RSpec.describe ProblemTranslation, type: :model do
  it { should validate_presence_of :language }

  it { should validate_presence_of :caption }

  it { should validate_presence_of :author }

  it { should validate_presence_of :text }

  it { should validate_presence_of :technical_text }

  it { should belong_to :problem }

  it { should define_enum_for(:language).with_values(I18n.available_locales) }
end
