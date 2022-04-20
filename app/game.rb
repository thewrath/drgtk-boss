class Game
  attr_gtk

  def defaults
    outputs.background_color = [0, 0, 0]
    state.boss  ||= Boss.new
  end

  def tick args
    self.args = args
    defaults
    state.boss.tick args
  end
end