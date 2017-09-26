class UsersSerializer < ActiveModel::Serializer
  attributes :id, :login, :avatar

  def avatar
    object.avatar.url
  end

  def comments
    object.comments.count
  end
end
