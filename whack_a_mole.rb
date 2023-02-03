require 'gosu'

class WhackAMole < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Whack a mole!'
    @mole = Gosu::Image.new('media/mole.png')
    @hammer = Gosu::Image.new('media/hammer.png')
    @x = 200
    @y = 200
    @width = 100
    @height = 75
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @hit = 0
  end

  def draw
    if @visible.positive?
      @mole.draw(@x - @width / 2, @y - @height / 2, 1)
    end
    @hammer.draw(mouse_x - 68, mouse_y - 50, 1)
    if @hit == 0
      c  = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
  end

  def button_down(id)
    if id == Gosu::MsLeft
      if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
        @hit = 1
      else
        @hit = -1
      end
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