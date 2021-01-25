class AddWordIdColumnToOppositeWords < ActiveRecord::Migration[5.2]
  def change
    add_column :opposite_words, :word_id, :integer
    add_column :opposite_words, :antonym_id, :integer
  end
end
