class QuestionsSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :tags, :comments_count

  def tags
    ActiveModelSerializers::SerializableResource.new(
        object.tags,
        each_serializer: TagSerializer,
        scope: scope
    )
  end
end
