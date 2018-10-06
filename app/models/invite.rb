class Invite < ApplicationRecord
  belongs_to :group

  belongs_to :sender, class_name: 'User'

  belongs_to :receiver, class_name: 'User'
end
