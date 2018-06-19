class Driver
  attr_reader :pos
  attr_reader :name

  def initialize(x = 0, y = 0, name = "No-name")
    @pos = Struct.new(:x, :y).new(x, y)
    @name = name
  end
end