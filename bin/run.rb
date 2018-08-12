require './lib/robot'
require './lib/tabletop'
require './lib/game'

robot = Robot.new
tabletop = Tabletop.new(5, 5)

game = Game.new(robot, tabletop)

loop do
  puts "\n>> Enter command:"
  command_string = gets.chomp
  begin
    game.exec_command(command_string)
  rescue Game::InvalidFirstCommandError
    puts 'Error: First command must be PLACE.'
    puts 'Example: PLACE 2,2,NORTH'
  rescue Game::InvalidCommandError
    puts 'Error: Only these commands are allowed:'
    puts Game::Commands::LIST.join(', ')
  rescue Game::PlaceCommandArgumentError, ArgumentError => error
    puts error.message
  end
end
