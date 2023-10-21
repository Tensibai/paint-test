require 'pp'

class Pixel
  # Shortcut to define getter and setter of color
  attr_accessor :color

  def initialize(x, y, color)
    @x = x
    @y = y
    @color = color
  end

  # Get up, down, left and right pixel from current position, given height and width of image to avoid returning out of image coordinates
  def getNeighbors(h,w)
    neighbors = []
    neighbors.append([@x-1,@y]) if @x > 0
    neighbors.append([@x+1,@y]) if @x < w
    neighbors.append([@x, @y-1]) if @y > 0
    neighbors.append([@x, @y+1]) if @y < h
    neighbors
  end
end

class Image
  def initialize(h, w, datas)
    @h = h
    @w = w
    @datas = datas.each_with_index.map do |value, idx|
      # Get X index of pixel from data, which is the modulo of data index by witdht
      x = idx % @h
      # Get Y index of pixel from data, which is the plain division of data index by witdht
      y = idx / @h
      # Create a new pixel with position and color
      Pixel.new(x,y,value)
    end
  end

  def datas
    # Return an array of color matching data input
    @datas.map { |n| n.color }
  end

  # Helper to access a specific pixel from coordinates
  def getPixel(x,y)
    return @datas[x+y*@w]
  end

  def change_color(x, y, new_color)
      # Get the input pixel from coordinates
      pixel = getPixel(x, y)
      # Get original color to be replaced
      to_replace = pixel.color
      # Loop over each pixel and change color if its color match the clicked pixel
      @datas.each do |pixel|
        if pixel.color == to_replace then
          pixel.color = new_color
        end
      end
  end

  def change_adjacent(x, y, new_color, to_replace=[])
    # Get the original pixel
    pixel = getPixel(x, y)
    # On first call, set the the color to be replaced
    if to_replace.empty?
      to_replace = pixel.color
    end
    if pixel.color == to_replace
      # Change pixel color if it match the original color
      pixel.color = new_color
      # Get adjacent pixels and make a recursive call for each adjacent pixel
      for n in pixel.getNeighbors(@h, @w)
        change_adjacent(n[0], n[1], new_color, to_replace)
      end
    end
  end
end
