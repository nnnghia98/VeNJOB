# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  region     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_cities_on_name  (name) UNIQUE
#

# In database
#   t.string :name, unique: true
#   t.string :region

class City < ApplicationRecord
end
