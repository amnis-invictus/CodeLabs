class Problem < ApplicationRecord
  validates :memory_limit, :time_limit, :real_time_limit, presence: true, numericality: true

  validates :private, inclusion: { in: [true, false] }

  belongs_to :user, optional: true

  belongs_to :checker_compiler, class_name: 'Compiler'

  has_one_attached :checker_source

  has_one :translation, -> { where language: I18n.locale }, class_name: 'ProblemTranslation'

  has_one :default_translation, -> { where default: true }, class_name: 'ProblemTranslation'

  has_many :translations, dependent: :destroy, class_name: 'ProblemTranslation'

  has_many :tests, dependent: :destroy

  has_many :examples, dependent: :destroy

  has_many :submissions, dependent: :destroy

  has_many :sharings, dependent: :destroy

  has_many :problems_tags, dependent: :destroy
  
  has_many :groups, through: :sharings

  has_many :tags, through: :problems_tags

  default_scope { includes :translation, :default_translation }

  delegate :as_json, to: :decorate

  accepts_nested_attributes_for :examples, :tests, :translations, allow_destroy: true
end
