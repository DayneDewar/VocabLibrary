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

      prompt.select("Sign in or Signup") do |menu|
          menu.choice "Sign in", -> {sign_in_helper}
          menu.choice "Sign up", -> {sign_up_helper}
          menu.choice "Exit", -> {exit_helper}
      end
  end

  def sign_in_helper
      username = prompt.ask("Please Enter Your Username", modify: :down)
      if self.user = User.find_by_username(username)
          puts "Welcome back #{user.username.capitalize()}"
          main_menu
      else
          puts "Username not found"
          welcome
      end
  end

  def sign_up_helper
      userinfo = prompt.collect do
          key(:name).ask("Please Enter Your Name", modify: :down)
          key(:age).ask("Please Enter Your Age", convert: :integer)
      end
      userinfo[:username] = username_helper
      #key(:password).ask("Please Enter a Password")
      self.user = User.create(userinfo)
      main_menu
  end

  def username_helper
      username = prompt.ask("Please Enter Your Username", modify: :down)
      while User.find_by_username(username)
          puts "This username is already taken, please try again"
          username = prompt.ask("Please Enter Your Username", modify: :down)
      end
      username
  end

  def main_menu
      system 'clear'
      prompt.select("What would you like to do>") do |menu|
          menu.choice "Exit", -> { exit_helper}
      end
  end

  def exit_helper
      system 'clear'
      puts "good bye"
      sleep (2)
      exit
  end

  private

  
end
