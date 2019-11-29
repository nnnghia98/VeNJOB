class CreateIndustries < ActiveRecord::Migration[6.0]
  def change
    create_table :industries do |t|
      t.string :name, unique: true

      t.timestamps
    end

    add_index :industries, :name, unique: true
  end
end
