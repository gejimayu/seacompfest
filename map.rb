class Map
  attr_reader :grid #map 2d
  attr_reader :size #size of map, n x n

  def initialize(size = 20)
    @size = size

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
      @grid[object.pos.y][object.pos.x] = "D"
    elsif object.is_a?(User)
      @grid[object.pos.y][object.pos.x] = "U"
    else
      puts "Error inserting object to map : expecting driver or user"  
    end
  end
end