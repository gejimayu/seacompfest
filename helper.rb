module Helper
  def Helper.generate_random_pos(map)
    posX = Random.rand(0...map.size)
    posY = Random.rand(0...map.size)
    Struct.new(:x, :y).new(posX, posY)
  end

  def Helper.generate_five_drivers_randomly(map)
    drivers = []
    for i in 0...5
      pos = generate_random_pos(map)
      driver = Driver.new(pos.x, pos.y, i.to_s)
      drivers << driver
      map.insert(driver)
    end
    drivers
  end

  def Helper.generate_drivers(map, drivers_pos)
    drivers = []
    for i in 0...drivers_pos.length
      pos = Struct.new(:x, :y).new(drivers_pos[i][0], drivers_pos[i][1])
      driver = Driver.new(pos.x, pos.y, i.to_s)
      drivers << driver
      map.insert(driver)
    end
    drivers
  end

  def Helper.is_out_of_bound(x, y, bound)
    return y < 0 || y >= bound || x < 0 || x >= bound
  end

  def Helper.calculate_distance(a, b)
    ((a.y - b.y) ** 2) + ((a.x - b.x) ** 2)
  end

  def Helper.find_closest_driver(user, drivers)
    raise "Error user / driver not found" if user.nil? || drivers.empty?

    min = calculate_distance(drivers[0].pos, user.pos)
    closest = 0 #driver num 0
    for i in 1...drivers.length
      result = calculate_distance(drivers[i].pos, user.pos) 
      if result < min
        min = result 
        closest = i
      end
    end

    closest
  end
end