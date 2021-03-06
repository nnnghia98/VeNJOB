class CreateUserJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_jobs do |t|
      t.references :user, foreign_key: true
      t.references :job, foreign_key: true
      t.datetime :applied_at
      t.datetime :viewed_at
      t.datetime :favorited_at

      t.timestamps
    end
  end
end
