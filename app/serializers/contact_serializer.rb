class ContactSerializer < ActiveModel::Serializer
  attributes :id, :number
  attribute :first_name, key: :firstName
  attribute :last_name, key: :lastName
end
