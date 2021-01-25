class AddWordIdColumnToSimilarWords < ActiveRecord::Migration[5.2]
  def change
    add_column :similarwords, :word_id, :integer
    add_column :similarwords, :synonym_id, :integer
  end
end
