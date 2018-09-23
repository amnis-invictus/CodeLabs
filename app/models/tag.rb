class Tag < ApplicationRecord
  has_one :translation, -> { where language: I18n.locale }, class_name: 'TagTranslation'

  has_many :translations, class_name: 'TagTranslation', dependent: :destroy

  has_and_belongs_to_many :problems

  default_scope { includes :translation }

  delegate :name, to: :translation, allow_nil: true
end
