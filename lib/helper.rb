module Helper

  #Generate random position based on map size
  def Helper.generate_random_pos(map)
    posX = Random.rand(0...map.size)
    posY = Random.rand(0...map.size)
    Struct.new(:x, :y).new(posX, posY)
  end

  #Generate five drivers object with random position
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

  #Generate drivers object based on positions provided by array drivers_pos
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

  #True if x or y is out of bound
  def Helper.is_out_of_bound(x, y, bound)
    return y < 0 || y >= bound || x < 0 || x >= bound
  end

  #Calculate distance between two point
  def Helper.calculate_distance(a, b)
    ((a.y - b.y) ** 2) + ((a.x - b.x) ** 2)
  end

  #Find closest drivers to user
  #drivers : array of object driver
  #user : object user
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

  #Return turning direction base on previos direction and next direction
  #0 : top, 1: right, 2 : bottom, 3: left
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

  #Generate direction if we move (top, bottom, left, right) from point a to point b
  #0 : top, 1: right, 2 : bottom, 3: left
  def Helper.direction(from, to)
    if to.x - from.x > 0
      1 #right
    elsif to.x - from.x < 0
      3 #left
    elsif to.y - from.y > 0
      2 #down
    else
      0 #top
    end
  end

  #Display route in a pretty way
  #user_pos: user's position
  #dest: destination point
  #path: array of path
  def Helper.show_path(user_pos, dest, path)
    route = "Route:\n"
    route += "Start at (#{user_pos.x}, #{user_pos.y})\n"
    head = -1
    now = user_pos
    path.each do |way|
      closest = direction(now, way)
      if head != -1 && head != closest
        route += turn_where(head, closest) + "\n"
      end

      now = way
      route += "Go to (#{now.x}, #{now.y})\n"

      head = closest
    end
    route += "Finish at (#{dest.x}, #{dest.y})\n"
  end

  #Generate array of point which is the shortest path from user_pos to dest
  def Helper.find_path(user_pos, dest)
    path = []
    now = user_pos
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
      now = Struct.new(:x, :y).new(now.x + diff_x[closest], now.y + diff_y[closest])
      path << now
    end
    path
  end

  #Save order history to file
  def Helper.save_to_file(filename, order)
    route_len = order.route.split("\n").length

    output_stream = open(filename, "a")

    output_stream.write(">> Order")
    output_stream.write("\n")
    output_stream.write("[Driver's name]")
    output_stream.write("\n")
    output_stream.write(order.driver_name)
    output_stream.write("\n")
    output_stream.write("[Route]")
    output_stream.write("\n")
    output_stream.write(route_len)
    output_stream.write("\n")
    output_stream.write(order.route)
    output_stream.write("[Cost]")
    output_stream.write("\n")
    output_stream.write(order.cost)
    output_stream.write("\n")

    output_stream.close
  end

  #Read order history from file
  def Helper.read_history(filename)
    begin
      input_stream = open(filename)
      orders = []

      line = input_stream.gets
      while (line == ">> Order\n")
        route = ""
        while ((line = input_stream.gets) && (line != ">> Order\n"))
          case line
          when "[Driver's name]\n"
            driver_name = input_stream.gets.chomp
          when "[Route]\n"
            n = input_stream.gets.chomp.to_i
            for i in 1..n
              route += input_stream.gets
            end
          when "[Cost]\n"
            cost = input_stream.gets.chomp
          end
        end
        orders << Order.new(driver_name, route, cost)
      end
      input_stream.close

      orders
    rescue Exception => e
      return e
    end
  end

end