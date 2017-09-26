class VoteSerializer < ActiveModel::Serializer
  attributes :rating, :vote

  def rating
    object.votable.rating
  end

  def vote
    object.rating
  end
end
