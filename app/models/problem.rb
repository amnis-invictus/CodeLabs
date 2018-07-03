class Problem < ApplicationRecord
  has_many :tests

  has_many :translations, class_name: 'ProblemTranslation'

  has_one :translation, -> { where language: I18n.locale }, class_name: 'ProblemTranslation'

  default_scope { includes :translation }
end
