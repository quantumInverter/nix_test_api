class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :rating, :vote

  def vote
    object.voted_by(scope) if scope
  end
end
