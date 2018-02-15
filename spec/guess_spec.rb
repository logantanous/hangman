require('rspec')
require('guess')
require('pry')

describe('guess') do
  it("checks if two words are the same") do
    test1 = Guess.new("test", "test")
    expect(test1.guess_word?).to(eq(true))
  end
end
