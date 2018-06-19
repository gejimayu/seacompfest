class User
  attr_reader :posX
  attr_reader :posY

  def initialize(x = 0, y = 0)
    @posX = x
    @posY = y
  end
end