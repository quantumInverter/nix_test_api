module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def rating
    votes.sum(:rating)
  end

  def voted_by(user)
    vote = Vote.where(user: user, votable: self)
    vote.first.rating if vote.any?
  end
end