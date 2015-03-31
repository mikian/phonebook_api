class ContactSerializer < ActiveModel::Serializer
  attributes :id, :number, :first_name, :last_name
end
