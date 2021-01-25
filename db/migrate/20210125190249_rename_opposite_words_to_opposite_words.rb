class RenameOppositeWordsToOppositeWords < ActiveRecord::Migration[5.2]
  def change
    rename_table :opposite_words, :oppositewords
  end
end
