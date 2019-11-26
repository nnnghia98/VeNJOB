class CreateCityJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :city_jobs do |t|
      t.references :city, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
