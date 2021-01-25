class OppositeWord < ActiveRecord::Base

    belongs_to :word
    belongs_to :antonym, class_name: 'Word', foreign_key: "word_id"

end