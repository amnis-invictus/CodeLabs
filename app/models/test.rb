class Test < ApplicationRecord
  validates :num, presence: true

  belongs_to :problem

  has_one_attached :input

  has_one_attached :answer

  default_scope { with_attached_input.with_attached_answer }

  delegate :as_json, to: :decorate
end
