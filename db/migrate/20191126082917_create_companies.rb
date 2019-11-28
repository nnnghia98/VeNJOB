class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email, unique: true
      t.text :description
      t.string :address

      t.timestamps
    end

    add_index :companies, :email, unique: true
  end
end
