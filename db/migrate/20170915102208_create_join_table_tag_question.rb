class CreateJoinTableTagQuestion < ActiveRecord::Migration[5.1]
  def change
    create_join_table :tags, :questions do |t|
      t.index [:tag_id, :question_id]
      # t.index [:question_id, :tag_id]
    end
  end
end
