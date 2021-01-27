class Word < ActiveRecord::Base

    has_many :word_list_relations
    has_many :vocab_lists, through: :word_list_relations
    has_many :similar_words
    has_many :synonyms, :through => :similar_words
    has_many :inverse_similar_words, :class_name => "SimilarWord", :foreign_key => "synonym_id"
    has_many :inverse_synonyms, :through => :inverse_similar_words, :source => :word
    has_many :opposite_words
    has_many :antonyms, :through => :opposite_words
    has_many :inverse_opposite_words, :class_name => "OppositeWord", :foreign_key => "antonym_id"
    has_many :inverse_antonyms, :through => :inverse_opposite_words, :source => :word

    def to_s
        self.word
    end
end


