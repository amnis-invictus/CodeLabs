class ProblemsTag < ApplicationRecord
  belongs_to :problem

  belongs_to :tag, counter_cache: :problems_count
end
