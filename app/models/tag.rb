class Tag < ApplicationRecord

  default_scope { order(questions_count: :desc) }

  has_and_belongs_to_many :questions
end
