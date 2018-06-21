require_relative "helper"

class Map
  attr_reader :size #size of map, n x n

  def initialize(size = 20)
    @size = size
    @drivers = []
    @grid = []
    for i in 1..size
      temp = Array.new(size, '.')
      @grid << temp
    end
  end

  #print 2d map in a pretty way
  def show 
    for i in 0...size
      for j in 0...size
        print @grid[i][j] + " "
      end
      print "\n"
    end
    print "\n"
  end

  #insert object into map
  def insert(object)
    if object.is_a?(Driver)
      if Helper.is_out_of_bound(object.pos.x, object.pos.y, size) 
        raise "Wrong input : driver's position is out of boundary"
      end
      @grid[object.pos.y][object.pos.x] = object.name
      @drivers << object
    elsif object.is_a?(User)
      if Helper.is_out_of_bound(object.pos.x, object.pos.y, size) 
        raise "Wrong input : user's position is out of boundary"
      end
      @grid[object.pos.y][object.pos.x] = "U"
      @user = object
    else
      puts "Error inserting object to map : expecting driver or user"  
    end
  end

  def find_closest_driver
    raise "Error user / driver not found" if @user.nil? || @drivers.empty?

    min = Helper.calculate_distance(@drivers[0].pos, @user.pos)
    closest = 0 #driver num 0
    for i in 1...@drivers.length
      result = Helper.calculate_distance(@drivers[i].pos, @user.pos) 
      if result < min
        min = result 
        closest = i
      end
    end

    closest
  end
end