class QuestionsSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :user, :rating, :tags, :comments_count, :created_at

  def content
    object.content[0..196] << '...'
  end

  def tags
    ActiveModelSerializers::SerializableResource.new(
        object.tags,
        each_serializer: TagSerializer,
        scope: scope
    )
  end

  def user
    ActiveModelSerializers::SerializableResource.new(
        object.user,
        each_serializer: UsersSerializer
    )
  end

  def created_at
    object.created_at.strftime("asked %b %d at %H:%M")
  end
end
