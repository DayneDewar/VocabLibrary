class CreateWordListRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :word_list_relations do |t|
      t.integer :vocab_list_id
      t.integer :word_id
      t.integer :user_id
    end
  end
end
