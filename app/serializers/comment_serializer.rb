class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user, :rating, :vote, :created_at

  def vote
    object.voted_by(scope) if scope
  end

  def user
    ActiveModelSerializers::SerializableResource.new(
        object.user,
        each_serializer: UsersSerializer
    )
  end

  def created_at
    object.created_at.strftime("answered %b %d at %H:%M")
  end
end
