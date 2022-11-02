class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :userid
      t.string :username
      t.string :password
      t.string :email
      t.boolean :email_verified
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :phone
      t.text :picture_url

      t.timestamps
    end
  end
end
