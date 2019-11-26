class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, unique: true
      t.string :username, unique: true
      t.integer :role
      t.string :password_digest
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.string :remember_digest
      t.string :activation_digest
      t.datetime :activated_at
      t.boolean :activated
      t.string :cv_path

      t.timestamps
    end
  end
end
