class Tabletop
  attr_accessor :length, :width

  def initialize(length, width)
    @length = length
    @width = width
  end

  def point_inside?(x, y)
    (x >= 0 && x < length) && (y >= -0 && y < width)
  end

  def point_outside?(x, y)
    !point_inside?(x, y)  
  end
end
