class Test < ApplicationRecord
  attr_accessor :input_text, :answer_text

  validates :num, presence: true

  validates :point, presence: true, numericality: { only_integer: true }

  belongs_to :problem

  has_one_attached :input

  has_one_attached :answer

  default_scope { with_attached_input.with_attached_answer.order :num }

  delegate :as_json, to: :decorate
end
