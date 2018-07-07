class Problem < ApplicationRecord
  has_many :examples

  has_and_belongs_to_many :tags

  has_many :tests

  has_many :translations, class_name: 'ProblemTranslation'

  has_one :translation, -> { where language: I18n.locale }, class_name: 'ProblemTranslation'

  default_scope { includes :translation }

  delegate :language, :caption, :author, :text, :technical_text, to: :translation, allow_nil: true
end
