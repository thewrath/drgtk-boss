class Game
  attr_gtk

  def defaults
    outputs.background_color = [0, 0, 0]
    state.boss  ||= Boss.new
    state.player  ||= Player.new
  end

  def tick args
    self.args = args
    defaults
    state.boss.tick args
    state.player.tick args
  end
end