class Order
  attr_reader :driver_name
  attr_reader :route
  attr_reader :cost
  
  def initialize(driver_name, route, cost)
    @driver_name = driver_name
    @route = route
    @cost = cost
  end
end