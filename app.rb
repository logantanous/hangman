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

post('/') do
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

  match = false

  until i == @@guy_template.length
    if correct_array[0] == @@letter_array[i]
      @@guy_template[i] = @@letter_array[i]
      match = true
    end
    i += 1
  end

  if match == false
    if @@guesses == 0
      @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;☹&nbsp;<br>"
    elsif @@guesses == 1
      @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;_☹&nbsp;<br>"
    elsif @@guesses == 2
      @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;_☹_<br>"
    elsif @@guesses == 3
      @@hanged_guy2 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;0<br>"
    elsif @@guesses == 4
      @@hanged_guy3 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;<br>"
    elsif @@guesses == 5
      @@hanged_guy3 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;/&nbsp;&nbsp;\\<br>"
    end
    @@guesses += 1
  end

  # @is_correct = false
  # until i == @@guy_template.length
  #   if correct_array[i] != @@letter_array[i]
  #     @is_correct = false
  #   else
  #     @is_correct = true
  #   end
  #   i += 1
  # end
  #
  # if @is_correct == false
  #   if @@guesses == 0
  #     @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;☹&nbsp;<br>"
  #   elsif @@guesses == 1
  #     @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;_☹&nbsp;<br>"
  #   elsif @@guesses == 2
  #     @@hanged_guy1 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;_☹_<br>"
  #   elsif @@guesses == 3
  #     @@hanged_guy2 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;0<br>"
  #   elsif @@guesses == 4
  #     @@hanged_guy3 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;<br>"
  #   elsif @@guesses == 5
  #     @@hanged_guy3 = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;/&nbsp;&nbsp;\\<br>"
  #   end
  #   @@guesses += 1
  # end
  #
  # if correct_array[@@letter_i] == @@letter_array[@@letter_i]
  #   @@guy_template[@@letter_i] = correct_array[@@letter_i]
  #   @@letter_i += 1
  # end


  # until @@letter_i == @@guy_template.length
  # # until correct_array == @@guy_template
  #   if correct_array[@@letter_i] == @@letter_array[@@letter_i]
  #     # @@guy_template[i] = correct_array[i]
  #     @@guy_template[@@letter_i] = "z"
  #   end
  #   @@letter_i += 1
  # end

  if guess.guess_word? == false
    # @hanged_guy = "|&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;_☹_<br>
    #     |&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;0<br>
    #     |&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;/&nbsp;&nbsp;\\<br>"
  end
  erb(:guess)
end
