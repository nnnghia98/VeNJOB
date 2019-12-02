class AddIndexToCompanyCode < ActiveRecord::Migration[6.0]
  def change
    add_index :companies, :company_code, unique: true
  end
end
