class ConfirmationRequest < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  delegate :name, :username, to: :user, prefix: true
end
