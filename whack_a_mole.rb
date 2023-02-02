require 'gosu'

class WhackAMole < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Whack a mole!'
    @mole = Gosu::Image.new('media/mole.png')
    @x = 200
    @y = 200
    @width = 100
    @height = 75
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
  end

  def draw
    if @visible.positive?
      @mole.draw(@x - @width / 2, @y - @height / 2, 1)
    end
  end

  def update
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= -1 if @x + @width / 2 > 800 || (@x - @width / 2).negative?
    @velocity_y *= -1 if @y + @height / 2 > 600 || (@y - @height / 2).negative?
    @visible -= 1
    @visible = 30 if @visible < - 10 && rand < 0.01
  end
end

window = WhackAMole.new
window.show