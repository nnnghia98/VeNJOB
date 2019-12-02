class CreateIndustryJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :industry_jobs do |t|
      t.references :industry, foreign_key: true
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
