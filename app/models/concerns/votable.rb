module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def rating
    votes.sum(:rating)
  end

  def voted_by(user)
    Vote.where(user: user, votable: self).first
  end
end