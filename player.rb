require 'byebug'

class Player
  def prompt
    puts "Please choose a card:"
  end

  def receive_guess(face_value)
    # duck typing
  end
end

class HumanPlayer < Player
  def get_input
    input = gets.chomp.split(",").map(&:to_i)
    input
  end
end

class ComputerPlayer < Player

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @guesses = Hash.new { |h, k| h[k] = [] }
    @current_guess = nil
    @previous_guess = nil
    @matched_cards = Hash.new { |h, k| h[k] = [] }
    @guessed_board = Array.new(@rows, Array.new(@columns, false))
  end

  def get_input

    matches = @guesses.select do |_, positions|
      positions.count == 2
    end
    # if on first guess
    # if any guesses value contains 2 positions, guess the first
    unless matches.empty?
      if !!@previous_guess
        @current_guess = matches.first.first # gets first position of first match
      # if on 2nd guess
      # if any guesses[1st guess] value contains 2 positions, guess 2nd'
      else
        @current_guess = matches[@previous_guess].last
      end
    # pick a random (non-guessed position)
    else
      generate_guess
    end
    @guessed_board[@current_guess.first][@current_guess.last] = true
    @current_guess
  end

  def receive_guess(face_value)
    @guesses[face_value] << @current_guess
    # moves current guess to previous in prep for 2nd guess
    if !@previous_guess
      @previous_guess = @current_guess
    # clears both guesses in prep for another guessing round
    else
      @previous_guess = nil
      @current_guess = nil
    end
  end

  def new_guess?(row, col)
    @guessed_board[row][col] == false
  end

  def generate_guess
    guess_made = false
    until guess_made
      puts "generating guess"
      @current_guess = [rand(@rows), rand(@columns)]
      puts "#{@current_guess} - #{@guessed_board[@current_guess.first][@current_guess.last]}"
      puts "#{@guesses} #{@matched_cards}"
      guess_made = new_guess?(*@current_guess)
    end
  end

end
