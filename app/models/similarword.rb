class SimilarWord < ActiveRecord::Base
    
    belongs_to :word
    belongs_to :synonym, class_name: 'Word', foreign_key: "word_id"
end