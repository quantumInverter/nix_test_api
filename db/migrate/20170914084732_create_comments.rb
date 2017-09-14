class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string      :content
      t.belongs_to  :user
      t.belongs_to  :question

      t.timestamps
    end
  end
end
