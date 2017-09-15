class QuestionsSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :all_tags, :comments_count
end
