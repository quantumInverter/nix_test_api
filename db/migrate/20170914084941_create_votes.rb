class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer     :votable_id
      t.string      :votable_type
      t.belongs_to  :user
      t.integer     :rating

      t.timestamps
    end

    add_index :votes, [:votable_id, :votable_type, :user_id], unique: true
  end
end
