# In db
# t.string :name
# t.string :email, unique: true
# t.text :description
# t.string :address

# add_index :industries, :name, unique: true

class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
end
