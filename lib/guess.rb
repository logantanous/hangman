class Guess
  def initialize(guess_input, correct_input)
    @guess_input = guess_input
    @correct_input = correct_input
  end

  def guess_word?
    if @guess_input != @correct_input
      false
    else
      true
    end
  end
end
