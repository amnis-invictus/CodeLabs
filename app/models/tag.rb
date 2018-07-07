class Tag < ApplicationRecord
  has_and_belongs_to_many :problems

  has_many :translations, class_name: 'TagTranslation'

  has_one :translation, -> { where language: I18n.locale }, class_name: 'TagTranslation'

  default_scope { includes :translation }

  delegate :language, :name, to: :translation, allow_nil: true
end
