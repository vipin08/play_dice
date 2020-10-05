require_relative 'model/player'
require 'terminal-table'

class GameUtility
  attr_accessor :player, :max_score, :players_won, :player_count

  @@player = []  # Player queue
  @@players_won = []

  def initialize payer_count, max_score
    @player_count = payer_count
    @max_score = max_score
    generate_player payer_count
  end

  def generate_player count
    count.times do |i|
      @@player.append(Player.new("Player_#{i}"))
    end
  end

  def game_over
    @@player.length == 0
  end

  def play
    if !game_over
      player = @@player.delete_at 0
      score = player.roll
      get_state = player_state(player, score)
      player.score += score
      player.current_roll = score
      player.status = get_state
      player.history.append(score)
      if player.status == Player::STATE[:BONUS]
        @@player.prepend(player)
      elsif player.status == Player::STATE[:END]
        @@players_won.append(player)
      else
        @@player.append(player)
      end
    end
  end

  def player_state(player, score=0)
      if player.score + score >= @max_score
          return Player::STATE[:END]
      elsif score == Player::MAX_VALUE
          return Player::STATE[:BONUS]
      elsif score == Player::MIN_VALUE and player.pre_score == Player::MIN_VALUE
          return Player::STATE[:SKIP]
      else
          return Player::STATE[:PLAY]
      end
  end

  def current_player
    @@player.first
  end

  def rank
    table = Terminal::Table.new do |t|
      t.style = {:width => 40, :padding_left => 3, :border_x => "=", :border_i => "x"}
      t.title = "Players Rank"
      t.headings = ['Name', 'Score']
      @@players_won.each do |p|
        t.add_row [p.name, p.score]
      end
    end
    puts table
  end

  def table
    table = Terminal::Table.new do |t|
      t.style = {:width => 40, :padding_left => 3, :border_x => "=", :border_i => "x"}
      t.title = "Players Data"
      t.headings = ['Name', 'Score']
      @@player.each do |p|
        t.add_row [p.name, p.score]
      end
    end
    puts table
  end

end
