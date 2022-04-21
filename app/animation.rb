module Animation
	def add_animation(key, sprite_sheet_length, tick_per_frame, repeat, reverse, tile_width, tile_height, path, orientation=:horizontal)
		@animations ||= {}
		@animations[key] = {
			sprite_sheet_length: sprite_sheet_length,
			tick_per_frame: tick_per_frame,
			repeat: repeat,
			reverse: reverse,
			tile_width: tile_width,
			tile_height: tile_height,
			path: path,
			orientation: orientation
		}
	end

	def set_current_animation(key)
	    raise "#{key} animation doesn't exists" if not @animations.key?(key)

		select_animation = @animations[key]	
		if select_animation != @current_animation
			@current_animation = @animations[key]
			@started_running_at = nil
		end
	end

	def pipe_animations(animations, frames)
	    raise "Need add least two animations" if animations.empty?
	    raise "Need duration for each animation in pipe" if animations.length != frames.length 

		@pipe_animation_index = 0 if not @pipe_animation_index or @pipe_animation_index >= animations.length

		set_current_animation(animations[@pipe_animation_index])

		@pipe_animation_start_at ||= state.tick_count
		if @pipe_animation_start_at.elapsed_time > frames[@pipe_animation_index]
			@pipe_animation_index += 1
			@pipe_animation_start_at = nil
		end
	end

	def get_current_sprite()
	    raise "@current_animation need to be set before accessing current animation sprite" if !@current_animation

	    @started_running_at ||= state.tick_count

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
	      tile_x: @current_animation.orientation == :vertical  ? 0 : (tile_index * @current_animation.tile_width),
	      tile_y: @current_animation.orientation == :horizontal  ? 0 : (tile_index * @current_animation.tile_height),
	      tile_w: @current_animation.tile_width,
	      tile_h: @current_animation.tile_height,
	      flip_horizontally: @current_animation.reverse,
	    }
  end
end