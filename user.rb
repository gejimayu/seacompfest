class User
  attr_reader :pos

  def initialize(x = 0, y = 0)
    @pos = Struct.new(:x, :y).new(x, y)
  end
end