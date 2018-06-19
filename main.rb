require_relative "driver"
require_relative "user"
require_relative "map"

flags = ARGV
case flags.length
when 0
  map = Map.new

  drivers = []
  #Generate 5 drivers
  for i in 1..5
    posX = Random.rand(0...map.size)
    posY = Random.rand(0...map.size)
    driver = Driver.new(posX, posY, "Driver" + i.to_s)
    drivers << driver
    map.insert(driver)
  end

  #init a user
  posX = Random.rand(0...map.size)
  posY = Random.rand(0...map.size)
  user = User.new(posX, posY)
  map.insert(user)

when 3
  size = flags[0].to_i
  userPosX = flags[1].to_i
  userPosY = flags[2].to_i

  if userPosY < 0 || userPosY >= size || userPosX < 0 || userPosX >= size
    puts "Wrong input : user's position is out of boundary"
    Kernel.exit(false)
  end

  map = Map.new(size)

  drivers = []
  #Generate 5 drivers 
  for i in 1..5
    posX = Random.rand(0...map.size)
    posY = Random.rand(0...map.size)
    driver = Driver.new(posX, posY, "Driver" + i.to_s)
    drivers << driver
    map.insert(driver)
  end

  user = User.new(userPosX, userPosY)
  map.insert(user)
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
