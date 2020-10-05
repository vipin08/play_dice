#ruby
#!/usr/bin/env ruby
require 'optparse'
require_relative 'main'
require_relative 'string/print_string'

options = {}
OptionParser.new do |parser|
  parser.on("-p", "--player PLAYER", "Number of players") do |value|
    options[:player] = value
  end
  parser.on("-m", "--max_score SCORE", "Maximum score") do |value|
    options[:max_score] = value
  end
end.parse!

if options[:player] and options[:max_score]
  puts "-----------------------------------"
  puts "Welcome to Dice Roll \n".light_blue
  puts "-----------------------------------"
  puts "Number of Players: ".green + "#{options[:player].yellow}" +", "+  "Maximum winning Score: ".green + "#{options[:max_score]}".yellow
  main = Main.new(options[:player].to_i, options[:max_score].to_i)
  main.play_dice
else
  puts "did you mean?".red
  puts "cmd.rb -p 10 -m 10".light_blue
  puts "cmd.rb --player 10 --max_score 10".light_blue
end