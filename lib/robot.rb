class Robot
  module Directions
    NORTH = 'NORTH'
    EAST = 'EAST'
    SOUTH = 'SOUTH'
    WEST = 'WEST'

    LIST = [NORTH, EAST, SOUTH, WEST]
  end

  attr_accessor :x, :y, :direction

  class UndefinedDirectionError < StandardError; end

  def place(x, y, direction)
    validate_direction(direction)

    @x = x
    @y = y
    @direction = direction
  end

  def move
    case direction
    when Directions::NORTH
      @y += 1
    when Directions::SOUTH
      @y -= 1
    when Directions::EAST
      @x += 1
    when Directions::WEST
      @x -= 1
    end
  end

  def left
    next_index = current_direction_index - 1
    next_index = (directions_amount - 1) if (next_index < 0)

    @direction = Directions::LIST[next_index]
  end

  def right
    next_index = current_direction_index + 1
    next_index = 0 if (next_index >= directions_amount)

    @direction = Directions::LIST[next_index]
  end

  def report
    [x, y, direction]
  end

  def direction_valid?(direction)
    Directions::LIST.include?(direction)
  end

  protected

  def validate_direction(direction)
    raise UndefinedDirectionError unless Directions::LIST.include?(direction)
  end

  def current_direction_index
    Directions::LIST.index(direction)
  end

  def directions_amount
    @directions_amount ||= Directions::LIST.size
  end
end
