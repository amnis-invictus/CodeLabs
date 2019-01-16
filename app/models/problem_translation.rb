class ProblemTranslation < ApplicationRecord
  validates :caption, :author, :text, :technical_text, presence: true

  validates :language, presence: true, uniqueness: { scope: :problem_id }

  validates :default, inclusion: { in: [true, false] }

  belongs_to :problem

  enum language: I18n.available_locales
end
