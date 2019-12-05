class AddCompanyCodeToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :code, :string, unique: true
    add_index :companies, :code, unique: true
  end
end
