class TestLib < ApplicationRecord
  validates :version, presence: true, uniqueness: true

  validate :binary_must_be_attached

  has_one_attached :binary

  delegate :as_json, to: :decorate

  private

  def binary_must_be_attached
    errors.add :binary, :blank unless binary.attached?
  end
end
