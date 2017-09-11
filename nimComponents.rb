class Nim
  attr_accessor :gameboard
  attr_accessor :configurations

  def initialize(gameboard)
    @gameboard = gameboard
  end

  # check if game is over
  def game_over?
    @gameboard.each do |i|
      return false if i != 0
    end
    return true
  end

  # display a move, changing zero-index row to 1-index
  def display_move(move)
    puts "#{move[:name]} removed #{move[:removed]} sticks from row #{move[:row] + 1}"
    move
  end

  # display the gameboard status
  def display_gameboard
    @gameboard.each_with_index do |val, index|
      puts "Row #{index + 1}: #{'X' * val}"
    end
  end

  # find parity of a gameboard
  # gameboard format is array of ints
  def parity
    p = 0
    # bitwise or each row of gameboard to find parity
    @gameboard.each do |i|
      p ^= i
    end
    p
  end

  # find the move required to put a gameboard into kernel state
  def smart_computer_player
    # use bitwise and to make a new gameboard that
    # removes any bits that are already canceled
    # out in the parity calculation, leaving the
    # board in a state such that the largest row
    # will be the one to be updated later
    tmp_board = @gameboard.map {|i| i &= parity}
    # get the largest row of the temp gameboard
    selected_row = tmp_board.each_with_index.max[1]
    # store the old value for later
    old_value = @gameboard[selected_row]
    # bitwise xor the selected row with the parity,
    # resulting in the new value of that row which
    # will cause the board to be in a kernel state
    new_value = @gameboard[selected_row] ^= parity

    # return a hash with move information to display
    m = {name: "Smart computer", row: selected_row, removed: old_value - new_value}
    display_move m
  end

  # make a random but valid move
  def dumb_computer_player
    # pick a random row and number of sticks to remove
    chosen_row = rand(@gameboard.size)
    chosen_row = rand(@gameboard.size) until @gameboard[chosen_row] != 0
    chosen_val = 1 + rand(@gameboard[chosen_row])

    # modify gameboard with move
    @gameboard[chosen_row] -= chosen_val

    # return a hash with move information
    m = {name: "Dumb computer", row: chosen_row, removed: chosen_val}
    display_move m
  end

  # allow a human to make a move
  def human_player
    # show the gameboard
    display_gameboard

    # get a row from the user
    user_row = 0
    max_row = @gameboard.size
    begin
      print "Select the row (1 - #{max_row}): "
      user_row = gets.chomp.to_i
      raise "bad index" if user_row < 1 || user_row > max_row
    rescue
      puts "The row must be between 1 and #{max_row}"
      retry
    end
    # convert rows to zero index
    user_row -= 1

    # get number of sticks to take
    user_sticks = 0
    max_sticks = @gameboard[user_row]
    begin
      print "Select the number of sticks (1 - #{max_sticks}): "
      user_sticks = gets.chomp.to_i
      raise "bad index" if user_sticks < 1 || user_sticks > max_sticks
    rescue
      puts "The number of sticks must be between 1 and #{max_sticks}"
      retry
    end

    # update gameboard with move
    @gameboard[user_row] -= user_sticks

    # return a hash with move information
    {name: "Human", row: user_row, removed: user_sticks}
  end
end
