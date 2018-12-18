class Tag < ApplicationRecord
  has_one :translation, -> { where language: I18n.locale }, class_name: 'TagTranslation'

  has_many :translations, class_name: 'TagTranslation', dependent: :destroy

  has_many :problems_tags, dependent: :destroy

  has_many :problems, through: :problems_tags

  default_scope { includes :translation }

  delegate :as_json, to: :decorate

  delegate :name, to: :translation, allow_nil: true
end
