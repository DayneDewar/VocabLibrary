class User < ActiveRecord::Base

    has_many :user_lists
    has_many :vocab_lists, through: :user_lists
    has_many :word_list_relations


def user_info
    #user_info = [name, age, username, password]
    puts "Name: #{name}\t\tAge: #{age}\t\tUsername: #{username}"
end


end