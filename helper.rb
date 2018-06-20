module Helper
  def Helper.generate_random_pos(map)
    posX = Random.rand(0...map.size)
    posY = Random.rand(0...map.size)
    Struct.new(:x, :y).new(posX, posY)
  end

  def Helper.generate_five_drivers_randomly(map)
    drivers = []
    for i in 1..5
      pos = generate_random_pos(map)
      driver = Driver.new(pos.x, pos.y, "Driver" + i.to_s)
      drivers << driver
      map.insert(driver)
    end
    drivers
  end

  def Helper.generate_drivers(map, drivers_pos)
    drivers = []
    for i in 0...drivers_pos.length
      pos = Struct.new(:x, :y).new(drivers_pos[i][0], drivers_pos[i][1])
      driver = Driver.new(pos.x, pos.y, "Driver" + i.to_s)
      drivers << driver
      map.insert(driver)
    end
    drivers
  end

  def Helper.is_out_of_bound(x, y, bound)
    return y < 0 || y >= bound || x < 0 || x >= bound
  end
end