class User < ActiveRecord::Base

    has_many :user_lists
    has_many :vocab_lists, through: :user_lists
    has_many :word_list_relations


    def user_info
        #user_info = [name, age, username, password]
        puts "Name: #{name.titleize}\t\tAge: #{age}\t\tUsername: #{username}"
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
        sleep(1.5)
    end

    def add_new_to_vocablist(word, definition, list)
        new_word = Word.create(word: word, definition: definition)
        add_existing_to_vocablist(new_word, list)
        puts "#{word} has been added to #{list}. Thank you for your contribution!"
        sleep(1.5)
    end




end