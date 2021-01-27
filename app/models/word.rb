class Word < ActiveRecord::Base

    has_many :word_list_relations
    has_many :vocab_lists, through: :word_list_relations
    has_many :similar_words
    has_many :synonyms, through: :similar_words
    has_many :opposite_words
    has_many :antonyms, through: :opposite_words



    def to_s
        self.word
    end
end


