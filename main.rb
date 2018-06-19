require_relative "driver"
require_relative "user"
require_relative "map"

flags = ARGV
case flags.length
when 0
  map = Map.new
  drivers = []
  for i in 1..5
    posX = Random.rand(0...map.size)
    posY = Random.rand(0...map.size)
    driver = Driver.new(posX, posY, "Driver" + i.to_s)
    drivers << driver
    map.insert(driver)
  end

  posX = Random.rand(0...map.size)
  posY = Random.rand(0...map.size)
  user = User.new(posX, posY)
  map.insert(user)
end

while true do
  puts "Main menu :"
  puts "1. Show map"
  puts "2. Order Go-Ride"
  puts "3. View History"
  print "Please pick an action > "
  option = gets.to_i
  case option
  when 1
    map.show
  else
    puts "Wrong input, expecting [1..3]"
    print "\n"
  end
end
