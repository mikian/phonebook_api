class Contact < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :number,     presence: true
end
