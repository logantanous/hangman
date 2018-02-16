class Hangman

  def initialize(input)
    @input = input
  end

  def split_word
    @character_array = @input.split("")
  end

  def blank_template
    word_length = @input.length
    word = ""
    i = 0
    loop do
      i += 1
      word = "#{word}_"
      if i == word_length
        break       # this will cause execution to exit the loop
      end       # this will cause execution to exit the loop
    end

    word
  end

end
