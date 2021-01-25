class VocabList < ActiveRecord::Base
  
  has_many :user_lists
  has_many :users, through: :user_lists
  has_many :word_list_relations
  has_many :words, through: :word_list_relations
end
