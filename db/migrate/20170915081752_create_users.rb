class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :login
      t.string  :password_digest
      t.string :country
      t.string :city
      t.string :address
      t.date   :birth_date

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :login,                unique: true
  end
end
