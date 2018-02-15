require('sinatra')
require('sinatra/reloader')
also_reload('lib/**.*.rb')
require('pry')
require('./lib/hang-man')

get('/') do
  erb(:setup)
end

post('/') do
  guess_word = params["word"]
  guess = Hangman.new(guess_word)
  @guess_template = guess.blank_template
  erb(:guess)
end
