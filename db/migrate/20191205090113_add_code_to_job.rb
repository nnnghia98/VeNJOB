class AddCodeToJob < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :code, :string, unique: true
    add_index :jobs, :code, unique: true
  end
end
