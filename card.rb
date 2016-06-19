require 'byebug'

class Card

  class << self
    FIRST_ASCII = 33
    LAST_ASCII = 126
    def generate_deck(pairs)
      if pairs > (LAST_ASCII - FIRST_ASCII)
        raise "Cannot generate #{pairs} pairs. Max allowed: #{LAST_ASCII - FIRST_ASCII}"
      end
      result = []
      pairs.times do |symbol_num|
        2.times { result << Card.nth_ascii(symbol_num) }
      end
      result.shuffle
    end

    def nth_ascii(n)
      (n + 33).chr
    end

  end

  public
  attr_reader :face_value

  def initialize(face_value)
    @face_value = face_value
    @revealed = false
  end

  def ==(arg)
    @face_value == arg.face_value
  end

  def hide
    @revealed = false
  end

  def reveal
    @revealed = true
    @face_value
  end

  def revealed?
    @revealed
  end

  def to_s
    @revealed ? @face_value : " "
  end

  private
  attr_reader :revealed

end

if __FILE__ == $PROGRAM_NAME
  p Card.generate_deck 2
  p Card.generate_deck 4
  p Card.generate_deck 5
  p Card.generate_deck 93
  p Card.generate_deck 100
end
