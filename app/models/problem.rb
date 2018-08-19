class Problem < ApplicationRecord
  attr_accessor :archive

  validates :memory_limit, :time_limit, presence: true, numericality: true

  belongs_to :checker_compiler, class_name: 'Compiler'

  has_one_attached :checker_source

  has_one :translation, -> { where language: I18n.locale }, class_name: 'ProblemTranslation'

  has_many :translations, class_name: 'ProblemTranslation'

  has_many :tests, -> { with_attached_input.with_attached_answer }

  has_many :examples

  has_and_belongs_to_many :tags

  default_scope { includes :translation }

  delegate :caption, :author, :text, :technical_text, to: :translation, allow_nil: true

  delegate :as_json, to: :decorate
end
