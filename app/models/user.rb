class User < ActiveRecord::Base

    has_many :user_lists
    has_many :vocab_lists, through: :user_lists
    has_many :word_list_relations

    def add_word(word, vocablist)
        word = Word.find_by(word: word)
        vocablist = VocabList.find_by(name: vocablist)
        WordListRelation.create(vocab_list_id: vocablist.id, word_id: word.id, user_id: self.id)
    end

end




