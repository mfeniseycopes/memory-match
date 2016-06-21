require_relative 'board.rb'
require_relative 'player.rb'

class Game

  def initialize(player)
    @player = player
    @board = Board.new(:easy)
    @board.populate
    @guessed_pos = nil
    @previous_guess = nil
  end

  def play
    until @board.won?
      prompt
    end
    puts "GAME OVER MAN!!!"
  end

  private
  def make_guess(row, column)
    unless @guessed_pos.nil?
      @previous_guess = @guessed_pos
    end

    @guessed_pos = [row, column]
    guess_response = nil
    unless @board.card_at(*@guessed_pos) && @board.card_at(*@guessed_pos).revealed?
      status = "You revealed #{@board.reveal(*@guessed_pos)}"
      guess_response = @board.reveal(*@guessed_pos)
    else
      status = "Card is already revealed. Guess again."
      @guessed_pos = nil
    end

    @board.render(status)
    guess_response
  end

  def match?
    @board.card_at(*@guessed_pos) == @board.card_at(*@previous_guess)
  end

  def guessing?
    @guessed_pos.nil? || @previous_guess.nil?
  end


  def prompt
    while guessing?

      @board.render
      @player.prompt
      r, c = @player.get_input
      @player.receive_guess make_guess(r, c)
    end

    if match?
      puts "You've got a match!"
    else
      puts "Not a match!"
      @board.card_at(*@guessed_pos).hide
      @board.card_at(*@previous_guess).hide
    end
    @guessed_pos = nil
    @previous_guess = nil
    sleep(2)
  end


end

p = HumanPlayer.new
Game.new(p).play

if __FILE__ == $PROGRAM_NAME
  p = HumanPlayer.new
  Game.new(p).play
end
