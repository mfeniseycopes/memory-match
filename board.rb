require_relative 'card.rb'

class Board

  DIFFICULTY = { easy: 2, medium: 4, hard: 10 }

  attr_reader :grid

  def initialize(difficulty_level)
    @difficulty = DIFFICULTY[difficulty_level]
    @grid = Array.new(@difficulty) { Array.new(@difficulty) }
  end

  def populate
    deck = Card.generate_deck(@difficulty)
    @grid.map! do |row|
      row.map! do |pos|
        pos = deck.pop
      end
    end
    @grid
  end

  def render(status = nil)
    system("clear")
    @grid.each do |row|
      puts "[#{ row.join("] [") }]"
    end
    puts status if !!status
  end

  def won?
    @grid.all? do |row|
      row.all? { |card| card.revealed? }
    end
  end

  def reveal(row, column)
    card_at(row, column).reveal
  end

  def card_at(row, column)
    if row < @grid.length && column < @grid.first.length
      @grid[row][column]
    else
      nil
    end
  end
end
