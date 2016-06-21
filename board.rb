require_relative 'card.rb'
require 'byebug'

class Board

  DIFFICULTY = { easy: 2, medium: 4, hard: 10 }

  attr_reader :grid

  def initialize(difficulty_level)
    @grid_size = DIFFICULTY[difficulty_level]
    @grid = Array.new(@grid_size) { Array.new(@grid_size) }
  end

  def [](pos)
    invalid_pos_error unless valid_pos? pos
    x, y = pos
    # debugger
    @grid[x][y]
  end

  def populate
    deck = Card.generate_deck (@grid_size ** 2)

    @grid.map! { |row| row.map! { |pos| pos = deck.pop } }
  end

  def render(status = nil)
    system("clear")
    @grid.each do |row|
      puts "[#{ row.join("] [") }]"
    end
    puts status if !!status
  end

  def reveal(pos)
    invalid_pos_error unless valid_pos? pos
    card = self[pos]
    card.reveal
  end

  def won?
    @grid.all? do |row|
      row.all? { |card| card.revealed? }
    end
  end

  private
  attr_accessor :grid_size

  def []=(pos, card)
    x, y = pos
    @grid[x][y] = card
  end

  def in_bounds?(pos)
    pos.all? { |el| el.between?(0, grid_size) }
  end

  def invalid_pos_error
    raise ArgumentError.new "Method takes Array of 2 numbers as argument"
  end

  def valid_pos?(pos)
    return true if pos.is_a?(Array) && pos.length == 2 &&
      pos.all? { |el| el.is_a? Numeric } &&
      in_bounds?(pos)
    false
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new :easy
  b.populate
  b.render
  b.reveal [0,0]
  b.render
end
