class CreateWordListRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :wordlistrelations do |t|
      t.integer :vocablist_id
      t.integer :word_id
      t.integer :user_id
    end
  end
end
