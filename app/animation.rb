module Animation
	def add_animation(key, sprite_sheet_length, tick_per_frame, repeat, reverse, path)
		@animations ||= {}
		@animations[key] = {
			sprite_sheet_length: sprite_sheet_length,
			tick_per_frame: tick_per_frame,
			repeat: repeat,
			reverse: reverse,
			path: path
		}
	end

	def set_current_animation(key)
	    raise "#{key} animation doesn't exists" if not @animations.key?(key)

		@current_animation = @animations[key]
	end

	def get_current_sprite()
	    raise "@current_animation need to be set before accessing current animation sprite" if !@current_animation

	    if !@started_running_at
	      tile_index = 0
	    else
	      tile_index = @started_running_at.frame_index(
		      	@current_animation.sprite_sheet_length, 
		      	@current_animation.tick_per_frame, 
		      	@current_animation.repeat
      		)
	    end

	    {
	      path: @current_animation.path,
	      tile_x: 0,
	      tile_y: (tile_index * 220),
	      tile_w: 220,
	      tile_h: 220,
	      flip_horizontally: @current_animation.reverse,
	    }
  end
end