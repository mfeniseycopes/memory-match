require 'byebug'

class Card

  # class
  def self.generate_deck(size)
    pairs = size / 2
    if pairs > (LAST_ASCII - FIRST_ASCII)
      raise "Cannot generate #{pairs} pairs. Max allowed: #{LAST_ASCII - FIRST_ASCII}"
    end
    result = []
    pairs.times do |symbol_num|
      2.times { result << Card.new(nth_ascii symbol_num) }
    end
    result.shuffle
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

  protected

  def self.nth_ascii(n)
    (n + 33).chr
  end


  private
  attr_writer :face_value
  attr_accessor :revealed

  FIRST_ASCII = 33
  LAST_ASCII = 126

end
