class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :avatar

  def avatar
    if object.avatar.attached?
      {
        id: object.avatar.id,
        name: object.avatar.name,
        path: object.avatar.url
      }
    end
  end
end