class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]

  validates :rating, numericality: { greater_than: -2, less_than: 2 }
end
