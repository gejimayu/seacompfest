require_relative "driver"
require_relative "user"
require_relative "map"
require_relative "helper"

Unit_Cost = 100

flags = ARGV
case flags.length
when 0
  map = Map.new

  drivers = Helper.generate_five_drivers_randomly(map)

  #init a user
  pos = Helper.generate_random_pos(map)
  user = User.new(pos.x, pos.y)
  map.insert(user)
  map.find_closest_driver

when 3
  size = flags[0].to_i
  user_pos_x = flags[1].to_i
  user_pos_y = flags[2].to_i

  if Helper.is_out_of_bound(user_pos_x, user_pos_y, size)
    raise "Wrong input : user's position is out of boundary"
  end

  map = Map.new(size)

  drivers = Helper.generate_five_drivers_randomly(map)

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

  if Helper.is_out_of_bound(user_pos_x, user_pos_y, size)
    raise "Wrong input : user's position is out of boundary"
  end

  map = Map.new(size)

  drivers = Helper.generate_drivers(map, driverPos)

  pos = Struct.new(:x, :y).new(user_pos_x, user_pos_y)
  user = User.new(pos.x, pos.y)
  map.insert(user)

else
  raise "Wrong parameters"
end

while true do
  print "\n"
  puts "Main menu :"
  puts "1. Show map"
  puts "2. Order Go-Ride"
  puts "3. View History"
  puts "4. Exit program"
  print "Please pick an action > "
  option = $stdin.gets.chomp.to_i
  print "\n"
  case option
  when 1
    map.show
  when 2
    puts "Where do you want to go ? "
    puts "Format input: x y"
    puts "Example: 1 2"
    print "Pick a coordinate > "
    temp = $stdin.gets.chomp.split(" ").map { |x| x.to_i }
    dest = Struct.new(:x, :y).new(temp[0], temp[1])
    print "\n"

    closest_driver = Helper.find_closest_driver(user, drivers)
    puts "Found driver #{drivers[closest_driver].name}"

    path = Helper.find_path(user.pos, dest)
    Helper.show_path(user.pos, dest, path)
  when 4
    Kernel.exit(false)
  else
    puts "Wrong input, expecting [1..4]"
    print "\n"
  end
end
