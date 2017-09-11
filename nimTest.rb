require 'minitest/autorun'

require_relative 'nimComponents'

class SmartComputerTest < MiniTest::Test
  def test_last_move
    game = Nim.new([0, 1, 0])
    m = game.smart_computer_player
    assert_equal(m[:removed], 1)
    assert_equal(m[:row], 1)
  end

  def test_no_parity
    game = Nim.new([0, 1, 1])
    m = game.smart_computer_player
    assert_equal(m[:removed], 0)
  end

  def test_duplicate_rows
    game = Nim.new([1, 2, 2])
    m = game.smart_computer_player
    assert_equal(m[:removed], 1)
    assert_equal(m[:row], 0)
  end

  def test_row_not_largest
    game = Nim.new([3, 5, 5])
    m = game.smart_computer_player
    assert_equal(m[:removed], 3)
    assert_equal(m[:row], 0)
  end
end
