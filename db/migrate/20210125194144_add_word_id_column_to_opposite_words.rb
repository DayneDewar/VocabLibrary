class AddWordIdColumnToOppositeWords < ActiveRecord::Migration[5.2]
  def change
    add_column :oppositewords, :word_id, :integer
    add_column :oppositewords, :antonym_id, :integer
  end
end
