# == Schema Information
#
# Table name: industries
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_industries_on_name  (name) UNIQUE
#

# In db
# t.string :name

class Industry < ApplicationRecord
end
