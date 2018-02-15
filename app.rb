require('sinatra')
require('sinatra/reloader')
also_reload('lib/**.*.rb')
require('pry')
require('./lib/hang-man')
require('./lib/guess')


get('/') do
  erb(:setup)
end

  @@word_one
  @@hanged_guy1
  @@hanged_guy2
  @@hanged_guy3
  @@guesses = 0
  @@letter_array = []

get('/hangman') do
  @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;<br>"
  @@hanged_guy2 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;<br>"
  @@hanged_guy3 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;<br>"



  # @hanged_guy = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;_☹_<br>
  #     |&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;0<br>
  #     |&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;/&nbsp;&nbsp;\\<br>"
  @put_word = params["word"]
  guy = Hangman.new(@put_word)
  @@guy_template = guy.blank_template
  @letters = guy.split_word
  @@word_one = @put_word
  @@letter_array = @letters
  erb(:guess)
end

post('/hangman') do
  @guess_word = params["guess"]
  correct_array = @guess_word.split("")
  guess = Guess.new(@guess_word, @@word_one)


  i = 0
  loop do
    if correct_array[i] != @@letter_array[i]
      if @@guesses == 0
        @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;☹&nbsp;<br>"
      end
      if @@guesses == 1
        @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;_☹&nbsp;<br>"
      end
      if @@guesses == 2
        @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;_☹_<br>"
      end
      if @@guesses == 3
        @@hanged_guy2 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;0<br>"
      end
      if @@guesses == 4
        @@hanged_guy3 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;<br>"
      end
      if @@guesses == 5
        @@hanged_guy3 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;/&nbsp;&nbsp;\\<br>"
      end
      @@guesses = @@guesses + 1;
      break
    end
    i += 1
  end

  if guess.guess_word? == false
    # @hanged_guy = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;_☹_<br>
    #     |&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;0<br>
    #     |&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;/&nbsp;&nbsp;\\<br>"
  end
  erb(:guess)
end
