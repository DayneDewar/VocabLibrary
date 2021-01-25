class User < ActiveRecord::Base

    has_many :userlists
    has_many :vocablists, through: :userlists
    has_many :wordlistrelations
end
