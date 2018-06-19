class Driver
  attr_reader :posX
  attr_reader :posY
  attr_reader :name

  def initialize(x = 0, y = 0, name = "No-name")
    @posX = x
    @posY = y
    @name = name
  end
end