class User < ActiveRecord::Base

    has_many :user_lists
    has_many :vocab_lists, through: :user_lists
    has_many :word_list_relations
end




