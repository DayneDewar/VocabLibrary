class VocabLibrary

  attr_reader :prompt
  attr_accessor :user


  

  def initialize 
    @prompt = TTY::Prompt.new
  end

  def run
      startup
  end

  def startup
      #something cool a banner maybe?
      welcome
  end

  def welcome
      system 'clear'
      prompt.select("Sign in or Signup") do |menu|
          menu.choice "Sign in", -> {sign_in_helper}
          menu.choice "Sign up", -> {sign_up_helper}
          menu.choice "Exit", -> {exit_helper}
      end
  end

  def sign_in_helper
      username = prompt.ask("Please Enter Your Username"){|q| q.modify :down}
      if self.user = User.find_by_username(username)
          puts "Welcome back #{user.username.capitalize()}"
          main_menu
      else
          puts "Username not found"
          sleep(1.5)
          welcome
      end
  end

  def sign_up_helper
      userinfo = prompt.collect do
          key(:name).ask("Please Enter Your Name"){|q| q.modify :down}
          key(:age).ask("Please Enter Your Age", convert: :integer)
      end
      userinfo[:username] = username_helper
      #key(:password).ask("Please Enter a Password")
      self.user = User.create(userinfo)
      main_menu
  end

  def username_helper
      username = prompt.ask("Please Enter Your Username"){|q| q.modify :down}
      while User.find_by_username(username)
          puts "This username is already taken, please try again"
          username = prompt.ask("Please Enter Your Username"){|q| q.modify :down}
      end
      username
  end

  def main_menu
      system 'clear'
      system 'reload'
      prompt.select("MAIN MENU") do |menu|
          menu.choice "My Profile", -> { my_profile}
          menu.choice "Browse Words", -> { browse_words}
          menu.choice "Browse VocabLists", -> { browse_vocablists}
          menu.choice "Account", -> { account_helper}
          menu.choice "Exit", -> { exit_helper}
      end
  end

  def my_profile
    system 'clear'
    system 'reload'
    puts "#{user.name.titleize}(#{user.username})\n\n"
    prompt.select("What would you like to see/do #{user.name.titleize}?") do |menu|
      menu.choice "My VocabLists", -> { my_vocablists}
      menu.choice "Add New VocabList", -> { add_new_vocablist}
      menu.choice "My Contributions", -> { my_contributions}
      menu.choice "Main Menu", -> { main_menu}
      menu.choice "Exit", -> {exit_helper}
    end
  end

  def my_vocablists
    system 'reload'
    system 'clear'
    lists = self.user.vocab_lists
    prompt.select("Choose a Vocablist you would like to study or type 'RETURN' ") do |menu|
      lists.each{|list| menu.choice "#{list}", -> { show_study_vocablist(list)}}
      menu.choice "RETURN", -> {my_profile}
    end
  end

  def show_study_vocablist(list)
    system 'reload'
    system 'clear'
    puts list
    words = list.words
    prompt.select("Choose a word you want to study or type 'RETURN'", filter: true) do |menu|
      menu.choice "ADD WORD TO VOCABLIST", -> { add_word_to_vocablist(list)}
      words.each{|word| menu.choice "#{word}", -> { show_study_word(word, list)}}
      menu.choice "REMOVE FROM PROFILE", -> { remove_list_from_profile(list)}
      menu.choice "RETURN", -> { my_vocablists}
    end
  end

  def show_study_word(word, list)
    system 'clear'
    puts word
    puts "Definition: #{word.definition}"
    puts "\n\n"
    prompt.select("") do |menu| 
      menu.choice "Synonyms", -> { view_study_synonyms(word)}
      menu.choice "Antonyms", -> { view_study_antonyms(word)}
      menu.choice "RETURN", -> { show_study_vocablist(VocabList.find(list.id))}
    end
  end

  def remove_list_from_profile(list_id)
    user.remove_my_list(user.id, list_id)
    system 'reload'
    user.reload
    my_vocablists
  end

  def add_list_to_profile(list_id)
    user.add_new_list_to_profile(list_id)
    user.reload
    system 'reload'
    my_vocablists
  end

  def add_new_vocablist
    prompt.select("Add from existing/ Create New") do |menu|
      menu.choice "From Existing", -> { browse_vocablists}
      menu.choice "Create New", -> {create_new_vocablist}
    end
  end

  def create_new_vocablist
    name = prompt.ask("Please enter a name for the VocabList"){|q| q.modify :down}
    user.user_create_new_vocablist(name)
    sleep(2)
    user.reload
    system 'reload'
    my_vocablists
  end

  def add_word_to_vocablist(list)
    word = prompt.ask("Please enter a word to add to #{list}")
    if newword = list.words.find {|words| words[:word]== word}
      puts "#{list} already has #{newword}"
      sleep(2)
      my_vocablists
    elsif newword = Word.find_by(word: word)
      user.add_existing_to_vocablist(newword, list)
      user.reload
      system 'reload'
      my_vocablists
    else
      definition = prompt.ask("Please enter a definition for #{newword}")
      user.add_new_to_vocablist(word, definition, list)
      user.reload
      system 'reload'
      my_vocablists
    end
  end

  def view_study_synonyms(word)
    puts "#{word} Synonyms"
    synonyms = word.synonyms
    if synonyms.length == 0
      system 'clear'
      puts "Pending synonym Approval"
      sleep(2)
      my_vocablists
    else
      synonyms.each{|synonym| puts synonym}
      prompt.select(""){|menu| menu.choice "Return to VocabList", -> { my_vocablists} }
    end
  end

  def view_study_antonyms(word)
    puts "#{word} Antonyms"
    antonyms = word.antonyms
    if antonyms.length == 0
      system 'clear'
      puts "Pending antonym Approval"
      sleep(2)
      my_vocablists
    else
      antonyms.each{|antonym| puts antonym}
      prompt.select(""){|menu| menu.choice "Return to VocabList", -> { my_vocablists} }
    end
  end

  def my_contributions
    system 'reload'
    user.list_contributions
    prompt.select("") do |menu|
      menu.choice "Remove a Word From List", -> { remove_word_from_list}
      menu.choice "Return", -> {my_profile}
    end
  end
    

  def remove_word_from_list
    system 'clear'
    contributions = user.word_list_relations
    prompt.select("Please choose which word/list pair to delete or Type 'Return to Profile") do |menu|
      contributions.each{|contribution| menu.choice "Remove #{Word.find(contribution.word_id)} from #{VocabList.find(contribution.vocab_list_id)}", -> {remove_word(contribution)}}
      menu.choice "Return to Profile", -> {my_profile}
    end
  end
  
  def remove_word(contribution)
    #relation = contribution
    contribution.destroy
    user.reload
    system 'reload'
    my_contributions
  end



  #BROWSE

  def browse_words
    system 'clear'
    all_words = Word.all.sort_by{|word| word[:word]}
    prompt.select("Choose or Enter a word you want to see.\nType 'MAIN MENU' to return to the Main Menu.", filter: true) do |menu|
      all_words.each{|word| menu.choice "#{word}", -> { show_word(word, all_words, {disabled: " "})}}
      menu.choice "Add Word into Database", -> {add_word_to_data_base}
      menu.choice "MAIN MENU", -> {main_menu}
    end
  end

  def show_word(word, list, hash = {} )
    system 'clear'
    puts word
    puts "Definition: #{word.definition}"
    puts "\n\n"
    prompt.select("") do |menu|
      menu.choice "Synonyms", -> {show_synonyms(word)}
      menu.choice "Antonyms", -> {show_antonyms(word)}
      menu.choice "Return to VocabList", -> { show_vocablist(list)}, hash
      menu.choice "Browse Words", -> { browse_words}
    end
  end
  
  def show_synonyms(word)
    puts "#{word} Synonyms"
    synonyms = word.synonyms
    synonyms.each{|synonym| puts synonym}
    prompt.select(""){|menu| menu.choice "Return to Browse Words", -> { browse_words} }
  end
  def show_antonyms(word)
    puts "#{word} Antonyms"
    antonyms = word.antonyms
    antonyms.each{|antonym| puts antonym}
    prompt.select(""){|menu| menu.choice "Return to Browse Words", -> { browse_words} }
  end

  def add_word_to_data_base
    system 'clear'
    word = prompt.ask("Please Enter Your Word"){|q| q.modify :down}
    if Word.find_by_word(word)
      puts "This word Already exists"
      sleep(1)
      browse_words
    else
      definition = prompt.ask("Please Enter the Deffinition of #{word}"){|q| q.modify :down}
      Word.create(word: word, definition: definition)
    end
    puts "#{word.capitalize} has been added to our database. Thank you for you contribution!"
    sleep(2)
    browse_words
  end



  def browse_vocablists
    system 'clear'
    all_vocablists = VocabList.all.sort_by{|list| list[:name]}
    prompt.select("Choose or Enter a Vocablist you want to see.\nType 'MAIN MENU' to return to the Main Menu.", filter: true) do |menu|
      all_vocablists.each{|list| menu.choice "#{list}", -> { show_vocablist(list)}}
      menu.choice "MAIN MENU", -> {main_menu}
    end
  end

  def show_vocablist(list)
    system 'clear'
    puts list
    words = list.words
    prompt.select("Choose a word you want to study or type 'RETURN'", filter: true) do |menu|
      menu.choice "Add to Profile", -> { add_list_to_profile(list.id)}
      words.each{|word| menu.choice "#{word}", -> { show_word(word, list,)}}
      menu.choice "RETURN", -> { browse_vocablists}
    end
  end


  def account_helper
    system 'clear'
    user.user_info
    prompt.select("What would you like to do?") do |menu|
      menu.choice "Update Name", -> {update_name_helper}
      menu.choice "Update Age", -> { update_age_helper}
      menu.choice "Main Menu", -> { main_menu}
      menu.choice "Delete Account", -> {delete_account_helper}
    end
  end

  def update_name_helper
    system 'clear'
    puts "Current Name: #{user.name.titleize}"
    new_name = prompt.ask("Please enter a new name", default: user.name.titleize){|q| q.modify :down}
    user.update(name: new_name)
    system 'reload'
    account_helper
  end

  def update_age_helper
    system 'clear'
    puts "Current Age: #{user.age}"
    new_age = prompt.ask("Please enter your age", convert: :integer, default: user.age)
    user.update(age: new_age)
    system 'reload'
    account_helper
  end

  def delete_account_helper
    value = prompt.yes?("Are you sure you want to delete your account")
    if value
      user.destroy
      system 'reload'
      system 'clear'
      welcome
    else
      account_helper
    end
  end


  def exit_helper
      system 'clear'
      puts "good bye"
      sleep (1)
      exit
  end

  private

  
end
