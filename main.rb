
require_relative 'model/player'
require_relative 'game_utility'

class Main
  INTRO_MESSAGE = 'Welcome to the Game of Dice'
  OUTRO_MESSAGE = 'Thank you!'

  def initialize player_count, max_score
    @player_count = player_count
    @max_score = max_score
    intro_msg
  end

  def intro_msg
    puts INTRO_MESSAGE.green
  end

  def play_dice
    game_utility = GameUtility.new(@player_count, @max_score)
    while !game_utility.game_over
      puts "#{game_utility.current_player&.name} its your turn (press ‘r’ to roll the dice): ".light_blue
      usr_cmd = gets.chomp
      if usr_cmd == "r"
          game_utility.play
          puts "Dice Roll: #{game_utility.current_player&.current_roll}".light_blue
          puts "Current Score: #{game_utility.current_player&.score}".light_blue
          game_utility.table
      else
        raise "Invalid command!!".red
      end
    end
    if game_utility.game_over
      game_utility.rank
    end
  end
end
