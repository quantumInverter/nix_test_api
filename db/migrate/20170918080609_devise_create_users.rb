class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :password_digest,   null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Data
      t.string  :login, null: false, default: ""
      t.string  :email, null: false, default: ""
      t.date    :birth_date
      t.string  :country
      t.string  :city
      t.string  :address
      t.integer :role_id, null: false, default: 0

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :login,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
