class AddWordIdColumnToSimilarWords < ActiveRecord::Migration[5.2]
  def change
    add_column :similar_words, :word_id, :integer
    add_column :similar_words, :synonym_id, :integer
  end
end
