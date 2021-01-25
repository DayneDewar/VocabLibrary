class Word < ActiveRecord::Base

    has_many :word_list_relations
    has_many :vocab_lists, through: :word_list_relations
    has_many :similarwords
    has_many :synonyms, through: :similar_words

end



