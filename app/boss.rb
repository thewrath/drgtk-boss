class Boss
  attr_gtk

  include Animation

  def defaults
    add_animation(:idle, 6, 8, true, false, 220, 220, 'sprites/bosses/death_king/idle.png', :vertical)
    add_animation(:attack, 10, 8, true, false, 220, 220, 'sprites/bosses/death_king/attack.png', :vertical)
    add_animation(:attack2, 9, 8, true, false, 220, 220, 'sprites/bosses/death_king/attack2.png', :vertical)
    add_animation(:attack3, 9, 8, true, false, 220, 220, 'sprites/bosses/death_king/attack3.png', :vertical)
    add_animation(:death, 12, 8, true, false, 220, 220, 'sprites/bosses/death_king/death.png', :vertical)
    add_animation(:hit, 4, 8, true, false, 220, 220, 'sprites/bosses/death_king/hit.png', :vertical)
    add_animation(:walk, 8, 8, true, false, 220, 220, 'sprites/bosses/death_king/walk.png', :vertical)

    set_current_animation(:idle) if not @current_animation
    
    @x  ||= 0
  end

  def tick args
    self.args = args
    defaults

    # @x  = -220 if @x > (grid.right - 220/2)
    outputs.sprites << {
      x: @x,
      y: 0,
      w: 220*4,
      h: 220*4,
    }.merge(get_current_sprite)
  end
end