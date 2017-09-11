# Nim Game
# Eric Olson
# CSCI400
#
# EASE OF GRADING: I used reflection to find computer players by searching
# the Nim class for methods with 'computer' in the name and storing those
# to an array. The chosen computer player is stored and used for subsequent
# calls requiring the computer player to make a move.

require_relative 'nimComponents.rb'

CONFIGURATIONS = [ [1, 3, 5, 7], [4, 3, 7] ]

# Display available configurations
puts "Welcome to NIM!"
CONFIGURATIONS.each_with_index do |val, index|
  puts "#{index + 1}: #{val}"
end

# Get configuration from user
max_config = CONFIGURATIONS.size
begin
  print "Select board configuration (1 - #{max_config}): "
  user_config = gets.chomp.to_i
  raise "bad index" if user_config < 1 || user_config > max_config
rescue
  puts "Board configuration must be between 1 and #{max_config}"
  retry
end
puts

# update selected config
config = CONFIGURATIONS[user_config - 1]

# create new game
game = Nim.new(config)

# choose computer player
players = Array.new

# put all methods with computer in the name in an array
player_index = 0
game.methods.each do |m|
  unless (m.to_s.match(/computer/).nil?)
    players.push m
    puts "#{player_index += 1}: #{m}"
  end
end

begin
  print "Select player (1 - #{player_index}): "
  player = gets.chomp.to_i
  raise "bad index" if player < 1 || player > player_index
rescue
  puts "Player must be between 1 and #{player_index}"
  retry
end
puts

# store selected player
computer = players[player - 1]
winner = computer

# play until game is over
until game.game_over?
  game.human_player
  if game.game_over?
    winner = "Human"
    break
  end
  puts
  game.send computer
  puts
end

# display game over message
puts "#{winner} wins the game!"
puts "Thank you for playing"
