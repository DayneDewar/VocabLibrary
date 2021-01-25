class RenameSimilarWordsToSimilarWords < ActiveRecord::Migration[5.2]
  def change

    rename_table :similar_words, :similarwords
  end
end
