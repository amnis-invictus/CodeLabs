class Problem < ApplicationRecord
  has_one :translation, -> { where language: I18n.locale }, class_name: 'ProblemTranslation'

  has_many :translations, class_name: 'ProblemTranslation'

  has_many :tests

  has_many :examples

  has_and_belongs_to_many :tags

  default_scope { includes :translation }

  delegate :caption, :author, :text, :technical_text, to: :translation, allow_nil: true
end
