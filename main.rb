require_relative "driver"
require_relative "user"
require_relative "map"
require_relative "helper"

flags = ARGV
case flags.length
when 0
  map = Map.new

  drivers = generateFiveDriversRandomly(map)

  #init a user
  pos = generateRandomPos(map)
  user = User.new(pos.x, pos.y)
  map.insert(user)

when 3
  size = flags[0].to_i
  user_pos_x = flags[1].to_i
  user_pos_y = flags[2].to_i

  if user_pos_y < 0 || user_pos_y >= size || user_pos_x < 0 || user_pos_x >= size
    puts "Wrong input : user's position is out of boundary"
    Kernel.exit(false)
  end

  map = Map.new(size)

  drivers = generateFiveDriversRandomly(map)

  pos = Struct.new(:x, :y).new(user_pos_x, user_pos_y)
  user = User.new(pos.x, pos.y)
  map.insert(user)

when 1
  filename = flags[0] 
  input_stream = open(filename)

  driverPos = []
  i = 0
  while (line = input_stream.gets)
    i += 1
    if i == 2
      size = line.to_i
    elsif i == 4
      pos = line.split(" ").map{|x| x.to_i}
      user_pos_x = pos[0]
      user_pos_y = pos[1]
    elsif i == 6
      num_drivers = line.to_i
    elsif i == 7
      for k in 1..num_drivers
        line = input_stream.gets
        pos = line.split(" ").map{|x| x.to_i}
        driverPos << [pos[0], pos[1]]
      end
    end
  end
  input_stream.close

  if user_pos_y < 0 || user_pos_y >= size || user_pos_x < 0 || user_pos_x >= size
    puts "Wrong input : user's position is out of boundary"
    Kernel.exit(false)
  end

  map = Map.new(size)

  drivers = generateDrivers(map, driverPos)

  pos = Struct.new(:x, :y).new(user_pos_x, user_pos_y)
  user = User.new(pos.x, pos.y)
  map.insert(user)

else
  puts "Wrong parameters"
  Kernel.exit(false)
end

while true do
  puts "Main menu :"
  puts "1. Show map"
  puts "2. Order Go-Ride"
  puts "3. View History"
  puts "4. Exit program"
  print "Please pick an action > "
  option = $stdin.gets.chomp.to_i
  case option
  when 1
    map.show
  when 4
    Kernel.exit(false)
  else
    puts "Wrong input, expecting [1..4]"
    print "\n"
  end
end
