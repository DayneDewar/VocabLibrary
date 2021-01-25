class Word < ActiveRecord::Base

    has_many :wordlistrelations
    has_many :vocablists, through: :wordlistrelations
    has_many :similarwords
    has_many :synonyms, through: :similarwords

end



