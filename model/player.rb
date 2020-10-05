class Player
  attr_accessor :name, :score, :status, :history, :current_roll
  STATE = {PLAY:'PLAY', BONUS:'BONUS', SKIP:'SKIP', END:'END'}
  MAX_VALUE = 6
  MIN_VALUE = 1
  # enum status: STATUS
  def initialize name, score=0, status=STATE[:PLAY]
    @name = name
    @score = score
    @status = status
    @current_roll = nil
    @history = []
  end

  def roll
    rand(MIN_VALUE..MAX_VALUE)
  end

  def pre_score
    @history[-1]
  end

end
