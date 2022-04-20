class Boss
  attr_gtk

  include Animation

  def defaults
    @started_running_at ||= state.tick_count
    
    add_animation(:idle, 6, 8, true, false, 'sprites/bosses/Old_King/idle.png')
    add_animation(:attack, 10, 8, true, false, 'sprites/bosses/Old_King/attack.png')
    add_animation(:attack2, 9, 8, true, false, 'sprites/bosses/Old_King/attack2.png')
    add_animation(:attack3, 9, 8, true, false, 'sprites/bosses/Old_King/attack3.png')
    add_animation(:death, 12, 8, true, false, 'sprites/bosses/Old_King/death.png')
    add_animation(:hit, 4, 8, true, false, 'sprites/bosses/Old_King/hit.png')
    add_animation(:walk, 8, 8, true, false, 'sprites/bosses/Old_King/walk.png')

    set_current_animation :idle if not @current_animation
    
    @x  ||= 0
  end

  def tick args
    self.args = args
    defaults

    # @x  = -220 if @x > (grid.right - 220/2)
    outputs.sprites << {
      x: @x,
      y: 0,
      w: 220*2,
      h: 220*2,
    }.merge(get_current_sprite)
  end
end