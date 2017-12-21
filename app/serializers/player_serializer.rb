class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :like, :created_at, :updated_at
end
