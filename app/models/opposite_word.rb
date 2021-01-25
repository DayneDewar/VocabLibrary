class OppositeWord < ActiveRecord::Base

    belongs_to :word
    belongs_to :antonym, :class_name => "Word"
end