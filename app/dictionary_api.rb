require 'net/http'
require 'open-uri'
require 'json'
require 'fileutils'
require 'oxford_dictionary'

class WordRequester

    def initialize(word)
        @word = word
    end 

    def get_oxford_body
        client = OxfordDictionary::Client.new(app_id: '51163151', app_key: 'a359822d89657ed4c907db3e4e5030a4')
        client = OxfordDictionary.new(app_id: '51163151', app_key: 'a359822d89657ed4c907db3e4e5030a4')
        # filters = { lexicalCategory: 'noun', }
        entry = client.entry(word: "#{@word}", dataset: 'en-gb', params: {})
        # entry.to_h
    end

    def oxford_word
        get_oxford_body[:word]
    end

    def oxford_definition
        get_oxford_body[:results]
    end

    
    def get_response_body
        uri = URI.parse("https://www.dictionaryapi.com/api/v3/references/collegiate/json/#{@word}?key=d2944aa0-c3cf-4476-9e6e-4652d034f6f2")
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def find_audio
        audio = json_parse[0]["hwi"]["prs"][0]["sound"]["audio"]
        audio
    end

    def numeric?(string)
        string =~ /[0-9]/
    end

    def find_audio_type
        if numeric?(self.find_audio[0])
            type = "number"
        else
            type = self.find_audio[0]
        end
        type
    end


    def sound
        File.write "#{@word}.wav", open("https://media.merriam-webster.com/audio/prons/en/us/wav/#{find_audio_type}/#{find_audio}.wav").read
        FileUtils.mv("#{@word}.wav", "./audio_files/#{@word}.wav")
        pid = fork{ exec 'afplay', "./audio_files/#{@word}.wav" }
    end

    def json_parse_audio
        program = JSON.parse(self.get_response_body)
        program
    end



end