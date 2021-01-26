require 'net/http'
require 'open-uri'
require 'json'

class GetRequester
   
    def initialize(word)
        @word = word
    end 

    def get_response_body
        uri = URI.parse("https://www.dictionaryapi.com/api/v3/references/collegiate/json/#{@word}?key=d2944aa0-c3cf-4476-9e6e-4652d034f6f2")
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def name
        
    end

    def sound
       
    end

    def definition
        
    end

    def json_parse
        program = JSON.parse(self.get_response_body)
        program
    end

end