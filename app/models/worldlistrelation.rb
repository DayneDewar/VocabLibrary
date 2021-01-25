class WordListRelation < ActiveRecord::Base

    belongs_to :vocablist
    belongs_to :word
    belongs_to :user

end
