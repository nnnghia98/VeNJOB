class AddCompanyCodeToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :company_code, :string, unique: true
  end
end
