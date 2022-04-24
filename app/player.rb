class Player
  attr_gtk

  include Animation

  def defaults    
    add_animation(:idle, 8, 8, true, false, 160, 111, 'sprites/king/Idle.png')
    add_animation(:run, 8, 8, true, false, 160, 111, 'sprites/king/Run.png')
    add_animation(:attack1, 4, 8, true, false, 160, 111, 'sprites/king/Attack1.png')
    add_animation(:attack2, 4, 8, true, false, 160, 111, 'sprites/king/Attack2.png')
    add_animation(:attack3, 4, 8, true, false, 160, 111, 'sprites/king/Attack3.png')
    add_animation(:hit, 4, 8, true, false, 160, 111, 'sprites/king/take_hit_white.png')
    add_animation(:death, 6, 10, true, false, 160, 111, 'sprites/king/Death.png')

    set_current_animation(:run) if not @current_animation
    
    @x  ||= 0
  end

  def tick args
    self.args = args
    defaults

    if inputs.keyboard.key_down.space
      pipe_animations([:attack2, :attack1, :attack3])
    end

    # @x  = -220 if @x > (grid.right - 220/2)
    outputs.sprites << {
      x: @x,
      y: 0,
      w: @current_animation.tile_width*4,
      h: @current_animation.tile_height*4,
    }.merge(get_current_sprite)
  end
end