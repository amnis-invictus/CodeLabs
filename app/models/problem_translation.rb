class ProblemTranslation < ApplicationRecord
  validates :language, :caption, :author, :text, :technical_text, presence: true

  belongs_to :problem

  enum language: I18n.available_locales
end
