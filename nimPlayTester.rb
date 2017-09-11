require_relative 'nimComponents'

20.times do
  game = Nim.new([1, 3, 5, 7])
  winner = "smart_computer_player"
  until game.game_over?
    game.dumb_computer_player
    if game.game_over?
      winner = "dumb_computer_player"
      break
    end
    puts
    game.smart_computer_player
    puts
  end
  puts "#{winner} wins!"
end
