class Gemfile
  EXCLUDED = ["rails"]

  def initialize(gemfile)
    @gems = scan_gems(gemfile) - EXCLUDED
  end

  def registered
    @registered ||= RubyGem.where(name: @gems).all
  end

  def unregistered
    @unregistered ||= @gems - registered.map(&:name)
  end

  def empty?
    @gems.empty?
  end

  private

  def scan_gems(gemfile)
    gemfile.scan(/^[ \t]*gem\s+['"](\S+)['"]/).flatten
  end
end
