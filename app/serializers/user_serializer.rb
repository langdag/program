class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :avatar
end