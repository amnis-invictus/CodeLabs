class Compiler < ApplicationRecord
  validates :name, :version, presence: true
end
