class Card
   require 'byebug'

  def self.generate_deck(pairs)
    alpha = ("A".."Z").to_a
    result = []
    alpha.take(pairs).each do |face_value|
      2.times { result << Card.new(face_value) }
    end
    result.shuffle
  end

  attr_reader :face_value

  def initialize(face_value)
    @face_value = face_value
    @revealed = false
  end

  def hide
    @revealed = false
  end

  def revealed?
    @revealed
  end

  def reveal
    @revealed = true
    @face_value
  end

  def to_s
    if @revealed
      @face_value
    else
      " "
    end
  end

  def ==(arg)
    @face_value == arg.face_value
  end
end
