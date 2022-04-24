module Animation
	def add_animation(key, sprite_sheet_length, tick_per_frame, repeat, reverse, tile_width, tile_height, path, orientation=:horizontal, cancellable=true)
		@animations ||= {}
		@animations[key] = {
			k: key,
			sprite_sheet_length: sprite_sheet_length,
			tick_per_frame: tick_per_frame,
			repeat: repeat,
			reverse: reverse,
			tile_width: tile_width,
			tile_height: tile_height,
			path: path,
			orientation: orientation,
			cancellable: cancellable
		}
	end

	def is_current_animation?(key)
		return @current_animation && @current_animation.k == key
	end

	def set_current_animation(key)
		raise "#{key} animation doesn't exists" if not @animations.key?(key)

		select_animation = @animations[key]
		if !@current_animation || (select_animation.k != @current_animation.k && @current_animation.cancellable) 
			@current_animation = select_animation
			@started_running_at = nil
		elsif @current_animation
			# Todo: maybe check if on_switch not already defined ??
			@current_animation.on_switch = Proc.new do
				@current_animation = select_animation
				@started_running_at = nil
			end
		end

		return @current_animation
	end

	def pipe_animations(animations, initial=true)
		return if animations.empty?
		animations.push(@current_animation.k) if initial && @current_animation
		head, *tail = animations
		set_current_animation(head).on_stop = Proc.new do
			pipe_animations(tail, false  )
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

		# raise top event on last frame
		last_frame = (tile_index == @current_animation.sprite_sheet_length - 1)
		@current_animation.on_stop.call if @current_animation.on_stop.respond_to?('call') && last_frame 
		@current_animation.on_switch.call if @current_animation.on_switch.respond_to?('call') && last_frame

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