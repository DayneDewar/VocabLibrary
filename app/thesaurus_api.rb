require 'net/http'
require 'open-uri'
require 'json'

class Thesaurus

    def initialize(word)
        @word = word
    end

    def synonyms
        json_parse[0]["meta"]["syns"][0].first(3)
    end

    def antonyms
        json_parse[0]["meta"]["ants"][0].first(3)
    end

    def get_response_body
        uri = URI.parse("https://dictionaryapi.com/api/v3/references/thesaurus/json/#{@word}?key=982ca2f8-bb8d-4641-bd49-4be8e2795de0")
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def json_parse
        program = JSON.parse(self.get_response_body)
        program
    end
    
end
