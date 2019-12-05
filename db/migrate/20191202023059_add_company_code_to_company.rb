class AddCompanyCodeToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :company_code, :string, unique: true
  end
  add_index :companies, :company_code, unique: true
end
