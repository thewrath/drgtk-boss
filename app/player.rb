class Player
  attr_gtk

  include Animation

  def defaults    
    add_animation(:idle, 8, 8, true, false, 160, 111, 'sprites/king/Idle.png')
    add_animation(:run_right, 8, 8, true, false, 160, 111, 'sprites/king/Run.png')
    add_animation(:run_left, 8, 8, true, true, 160, 111, 'sprites/king/Run.png')
    add_animation(:attack1, 4, 8, true, false, 160, 111, 'sprites/king/Attack1.png', :horizontal, false)
    add_animation(:attack2, 4, 8, true, false, 160, 111, 'sprites/king/Attack2.png')
    add_animation(:attack3, 4, 8, true, false, 160, 111, 'sprites/king/Attack3.png')
    add_animation(:hit, 4, 8, true, false, 160, 111, 'sprites/king/take_hit_white.png')
    add_animation(:death, 6, 10, true, false, 160, 111, 'sprites/king/Death.png')

    set_current_animation(:idle) if not @current_animation
    
    @x  ||= 0
    @velocity ||= {x: 0, y: 0}
  end

  def tick args
    self.args = args
    defaults

    if inputs.keyboard.key_held.right
      @velocity.x = 8
      set_current_animation(:run_right)
    elsif inputs.keyboard.key_held.left
      @velocity.x = -8
      set_current_animation(:run_left)
    end

    if inputs.keyboard.key_down.space and @velocity.x == 0
      set_current_animation(:attack1)
    end

    @x = @x + @velocity.x

    set_current_animation(:idle) if @velocity.x == 0 and not is_current_animation?(:idle)

    @velocity.x = @velocity.x - 1 if @velocity.x > 0 
    @velocity.x = @velocity.x + 1 if @velocity.x < 0 

    outputs.sprites << {
      x: @x,
      y: 0,
      w: @current_animation.tile_width*4,
      h: @current_animation.tile_height*4,
    }.merge(get_current_sprite)
  end
end