class UserSerializer < ActiveModel::Serializer
  attributes :id, :login, :birth_date, :country, :city, :address, :avatar

  def avatar

  end
end
