class AddQuestionsCountToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :questions_count, :integer, null: false, default: 0
  end
end
