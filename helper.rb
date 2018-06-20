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

  def Helper.turn_where(prev_head, next_head)
    if prev_head == 0 && next_head == 1
      "Turn right"
    elsif prev_head == 0 && next_head == 2
      "Turn around"
    elsif prev_head == 0 && next_head == 3
      "Turn left"
    elsif prev_head == 1 && next_head == 0
      "Turn left"
    elsif prev_head == 1 && next_head == 2
      "Turn right"
    elsif prev_head == 1 && next_head == 3
      "Turn around"
    elsif prev_head == 2 && next_head == 0
      "Turn around"
    elsif prev_head == 2 && next_head == 1
      "Turn left"
    elsif prev_head == 2 && next_head == 3
      "Turn right"
    elsif prev_head == 3 && next_head == 0
      "Turn right"
    elsif prev_head == 3 && next_head == 1
      "Turn around"
    elsif prev_head == 3 && next_head == 2
      "Turn left"
    end
  end

  def Helper.find_path(user, dest)
    path = []
    now = user.pos
    path << "Start at (#{now.x}, #{now.y})"
    #top right bottom left
    diff_x = [0, 1, 0, -1]
    diff_y = [-1, 0, 1, 0]
    head = -1
    while now.x != dest.x || now.y != dest.y do
      way = Struct.new(:x, :y).new(now.x + diff_x[0], now.y + diff_y[0])
      closest = 0
      min = Helper.calculate_distance(way, dest)
      for i in 1..3
        way = Struct.new(:x, :y).new(now.x + diff_x[i], now.y + diff_y[i])
        temp = Helper.calculate_distance(way, dest)
        if temp < min
          min = temp
          closest = i
        end
      end
      
      if head != -1 && head != closest
        path << turn_where(head, closest)
      end
      head = closest

      now = Struct.new(:x, :y).new(now.x + diff_x[closest], now.y + diff_y[closest])
      path << "Go to (#{now.x}, #{now.y})"
    end
    path << "Finish at (#{dest.x}, #{dest.y})"
  end
end