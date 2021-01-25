class CreateVocabLists < ActiveRecord::Migration[5.2]
  def change
    create_table :vocab_lists do |t|
      t.string :name
    end
  end
end
