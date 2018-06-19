def generateRandomPos(map)
  posX = Random.rand(0...map.size)
  posY = Random.rand(0...map.size)
  Struct.new(:x, :y).new(posX, posY)
end

def generateFiveDriversRandomly(map)
  drivers = []
  for i in 1..5
    pos = generateRandomPos(map)
    driver = Driver.new(pos.x, pos.y, "Driver" + i.to_s)
    drivers << driver
    map.insert(driver)
  end
  drivers
end

def generateDrivers(map, drivers_pos)
  drivers = []
  for i in 0...drivers_pos.length
    pos = Struct.new(:x, :y).new(drivers_pos[i][0], drivers_pos[i][1])
    driver = Driver.new(pos.x, pos.y, "Driver" + i.to_s)
    drivers << driver
    map.insert(driver)
  end
  drivers
end