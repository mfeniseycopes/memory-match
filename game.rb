require_relative 'board.rb'
require_relative 'player.rb'

class Game

  def initialize(player, difficulty = :easy)
    @player = player
    @board = Board.new(difficulty)
    @board.populate
    @guesses = []
  end

  def play
    until @board.won?
      reset_guesses
      prompt
      process_guesses
    end
    puts "GAME OVER MAN!!!"
  end

  private

  def first_guess
    @guesses.first
  end

  def guessing?
    @guesses.length < 2
  end

  def hide_guesses
    @guesses.each { |guess| @board[guess].hide }
  end

  def last_guess
    @guesses.last
  end

  def make_guess(pos)
    @board.validate_position(pos)

    @guesses << pos
    if @board[last_guess].revealed?
      raise "Card already matched. Try again!"
    else
      @board.reveal(last_guess)
    end
  end

  def match?
    !guessing? &&
    @board[first_guess] == @board[last_guess]
  end

  def process_guesses
    if match?
      puts "You've got a match!"
    else
      puts "Not a match!"
      hide_guesses
    end
  end

  def prompt
    while guessing?
      @board.render
      @player.prompt
      @player.receive_guess make_guess(@player.get_input)
      @board.render
    end

  end

  def reset_guesses
    @guesses = []
  end

  def reveal_guesses
    @guesses.each { |guess| @board[guess].reveal }
  end

end

if __FILE__ == $PROGRAM_NAME
  difficulty = ARGV.shift
  board_difficulty = :easy

  if difficulty == "med"
    board_difficulty = :med
  elsif difficulty == "hard"
    board_difficulty = :hard
  end

  p = HumanPlayer.new
  Game.new(p, board_difficulty).play
end
