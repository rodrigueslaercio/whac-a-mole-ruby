require 'gosu'

class WhackAMole < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Whack a mole!'
    @mole = Gosu::Image.new('media/mole.png')
    @second_mole = Gosu::Image.new('media/mole.png')
    @hammer = Gosu::Image.new('media/hammer.png')
    @x = 200
    @y = 200
    @width = 100
    @height = 75
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @hit = 0
    @font = Gosu::Font.new(30)
    @score = 0
    @playing = true
    @start_time = 0
    @hits = 0
    @wrongs = 0
  end

  def draw
    if @visible.positive?
      @mole.draw(@x - @width / 2, @y - @height / 2, 1)
    end
    @hammer.draw(mouse_x - 120, mouse_y - 45, 1)
    if @hit.zero?
      c  = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    @hit = 0
    @font.draw_text("Score: #{@score}", 650, 20, 2)
    @font.draw_text("Time left: #{@time_left}", 20,20,2)
    @font.draw_text("Hits: #{@hits} ", 20,70,2)
    @font.draw_text("Errors: #{@wrongs}", 20, 100, 2)
    unless @playing
      @font.draw_text('Game Over', 300, 300, 3)
      @font.draw_text('Press Space Bar to Play Again', 175, 350, 3)
      @visible = 20
    end
  end

  def needs_cursor?
    false
  end

  def button_down(id)
    if @playing
      if id == Gosu::MsLeft
        if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
          if @time_left <= 60
            @score += 2
          else
            @score += 5
          end
          @hits += 1
          @hit = 1
          @visible = -1
        else
          @time_left -= 10
          if @time_left <= 60
            @score -= 15
          else
            @score -= 1
          end
          @hit = -1
          @wrongs += 1
          @visible = -1
        end
      end
    else
      if id == Gosu::KbSpace
        @playing = true
        @visible = -10
        @start_time = Gosu.milliseconds
        @score = 0
        @hits = 0
        @wrongs = 0
      end
    end
  end

  def update
    if @playing
      @x += @velocity_x
      @y += @velocity_y
      @velocity_x *= -1 if @x + @width / 2 > 800 || (@x - @width / 2).negative?
      @velocity_y *= -1 if @y + @height / 2 > 600 || (@y - @height / 2).negative?
      @visible -= 1
      @time_left = (100 - ((Gosu.milliseconds - @start_time) / 1000))
      @playing = false if @time_left.zero?

      if @time_left <= 60
        @visible = 30 if @visible < - 10 && rand < 0.05
      else
        @visible = 30 if @visible < - 10 && rand < 0.01
      end
    end
  end
end

window = WhackAMole.new
window.show