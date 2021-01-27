class UserList < ActiveRecord::Base

    belongs_to :user
    belongs_to :vocab_list
    
    
end
