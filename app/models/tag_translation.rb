class TagTranslation < ApplicationRecord
  validates :language, :name, presence: true

  belongs_to :tag

  enum language: I18n.available_locales
end
