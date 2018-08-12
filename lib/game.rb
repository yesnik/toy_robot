class Game
  attr_accessor :robot, :tabletop

  module Commands
    PLACE = 'PLACE'
    MOVE = 'MOVE'
    LEFT = 'LEFT'
    RIGHT = 'RIGHT'
    REPORT = 'REPORT'

    LIST = [PLACE, MOVE, LEFT, RIGHT, REPORT]
  end

  class InvalidCommandError < StandardError; end
  class InvalidFirstCommandError < StandardError; end

  def initialize(robot, tabletop)
    @robot = robot
    @tabletop = tabletop
  end

  def exec_command(commands_string)
    commands_string.split("\n").each do |command|
      exec_single_command(command)
    end
  end

  def position_valid?(x, y)
    tabletop.point_inside?(x, y)
  end

  protected

  def exec_single_command(command_string)
    command = command_name(command_string)
    raise InvalidCommandError unless command_valid?(command)
    
    unless execution_allowed?(command)
      raise InvalidFirstCommandError, 'First command must be PLACE'
    end

    case command
    when Commands::PLACE
      x, y, direction = args_of_place_command(command_string)
      robot.tap do |r|
        r.x = x.to_i
        r.y = y.to_i
        r.direction = direction
      end
    when Commands::MOVE
      robot.move
    when Commands::LEFT
      robot.left
    when Commands::RIGHT
      robot.right
    when Commands::REPORT
      print robot.report.join(',')
    end
  end

  def command_valid?(command)
    Commands::LIST.include?(command)
  end

  def command_name(command_string)
    command_string.split(' ').first
  end

  def args_of_place_command(command_string)
    _command_name, args_string = command_string.split(' ')
    args = args_string.split(',')
    validate_place_args(args)

    args
  end

  def validate_place_args(args)
    if !number?(args[0]) || !number?(args[1])
      raise ArgumentError, 'First and Second arguments must be numbers'
    end

    unless Robot.direction_valid?(args[2])
      raise ArgumentError, 'Invalid direction type'
    end
  end

  def number?(string)
    true if Float(string) rescue false
  end

  def execution_allowed?(command)
    @execution_allowed ||= (command == Commands::PLACE)
  end
end
