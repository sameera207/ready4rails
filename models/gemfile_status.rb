class GemfileStatus
  EXCLUDED = ["rails"]

  attr :gems

  def initialize gems
    @gems = gems - EXCLUDED
  end

  def registered
    RubyGem.fetch_by_name(gems)
  end

  def unregistered
    gems - registered.map(&:name)
  end
end
