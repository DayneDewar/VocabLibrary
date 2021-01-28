require 'active_support'
require 'active_support/core_ext'
require 'fileutils'
class User < ActiveRecord::Base

    has_many :user_lists
    has_many :vocab_lists, through: :user_lists
    has_many :word_list_relations

    def user_info
        #user_info = [name, age, username, password]
        puts "Name: #{name.titleize}\t\tAge: #{age}\t\tUsername: #{username}"
    end

    def add_word_to_db(word)
        if new_word = Word.find_by(word: word)
            puts "#{word} is already in our database"; sleep(2)
            return nil
        else
            new_word = Dictionary.new(word)
            add_word = new_word.oxford_word
            if !add_word
                add_word = word
                response = "Please enter a definition for #{word}"
                return response
            else
                definition = new_word.oxford_definition
                new_word.sound
            end
            added_word = Word.create(word: word, definition: definition)
            puts "Thank You, #{added_word} has been added to our database"; sleep(1.5)
            return nil
        end
    end

    def add_synonyms(word)
        synonyms = Thesaurus.new(word.word).synonyms
        if synonyms.length > 0
            synonyms.each do |synonym| 
                if synonym.include? " "
                    next
                else
                    add_word_to_db(synonym)
                    system 'reload'
                    SimilarWord.create(synonym_id: Word.last.id, word_id: word.id)
                    system 'reload'
                    self.reload
                end
            end
            system 'reload'
            self.reload
        else
            puts "No synonyms found at this time";sleep(2)
        end
    end

    def add_antonyms(word)
        antonyms = Thesaurus.new(word.word).antonyms
        if antonyms.length > 0
            antonyms.each do |antonym| 
                if synonym.include? " "
                    next
                else
                    add_word_to_db(antonym)
                    system 'reload'
                    OppositeWord.create(antonym_id: Word.last.id, word_id: word.id)
                    system 'reload'
                    self.reload
                end
            end
            system 'reload'
            self.reload
        else
            puts "No anotnyms found at this time"; sleep(2)
        end
    end



    def add_made_up_word(word, definition)
        new_word = Word.create(word: word, definition: definition)
        puts "Thank You, #{word} has been added to our database"; sleep(2)
    end


    def add_new_list_to_profile(list_id)
        new_list = UserList.find_by(user_id: self.id, vocab_list_id: list_id)
        if new_list
            puts "This list is already in your profile"
            sleep(2)
            return
        else
            return new_list = UserList.create(user_id: self.id, vocab_list_id: list_id)
        end

    end

    def user_create_new_vocablist(name)
        vocablist = VocabList.find_by(name: name)
        if vocablist 
            return puts "VocabList already exists. Please choose a different name"
        else
            vocablist = VocabList.create(name: name)
        end
        userlist = UserList.create(user_id: self.id, vocab_list_id: vocablist.id)
        puts "#{name} VocabList has been created!"
    end

    def remove_my_list(user_id, list_id)
        userlist = UserList.find_by(user_id: user_id, vocab_list_id: list_id)
        userlist.destroy
    end

    def list_contributions
        my_contributions = self.word_list_relations
        my_contributions.each{|relation| puts "Added #{Word.find(relation.word_id)} to #{VocabList.find(relation.vocab_list_id)}"}
    end

    def add_existing_to_vocablist(word, list)
        word_list_relation = WordListRelation.create(vocab_list_id: list.id, word_id: word.id, user_id: self.id)
        puts "#{word} has been added to #{list}. Thank you for your contribution!"
        sleep(2)
    end

    def add_new_to_vocablist(list)
        new_word = Word.last
        add_existing_to_vocablist(new_word, list)
    end

    def play_sound(word)
        pid = fork{ exec 'afplay', "./audio_files/#{word}.wav" }
    end

    def add_word_of_the_day(num_days)
        num_days.times do |i|
            word = Word.all.sample
            deff = word.definition
            cal = Icalendar::Calendar.new
            event = Icalendar::Event.new
            event.dtstart = Date.today + (i+1).days
            event.summary = "Todays Word of the Day is: #{word} - #{deff}"
            cal.add_event(event)
            cal.publish
            file = File.open("#{self.username}_word_#{i+1}.ics","w") do |f|
                f.write(cal.to_ical)
            FileUtils.mv("#{self.username}_word_#{i+1}.ics", "./cal_files/#{self.username}_word_#{i+1}.ics")
            
            system 'open', "./cal_files/#{self.username}_word_#{i+1}.ics"
            end
        end  
    end    
end