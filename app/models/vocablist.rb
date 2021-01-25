class VocabList < ActiveRecord::Base
  
  has_many :userlists
  has_many :users, through: :userlists
  has_many :wordlistrelations
  has_many :words, through: :wordlistrelations
end
