# In database
#   t.string :title
#   t.string :level
#   t.string :salary
#   t.string :other_salary
#   t.text :description
#   t.text :short_des
#   t.text :requirement
#   t.integer :category
#   t.datetime :post_date
#   t.datetime :expiration_date
#   t.references :company, null: false, foreign_key: true

class Job < ApplicationRecord
  belongs_to :company
end
