class Gemfile
  EXCLUDED = %w(rails)

  attr :gems

  def initialize(gemfile)
    @gems = scan_gems(gemfile) - EXCLUDED
  end

  def registered
    @registered ||= RubyGem.fetch_by_name(gems)
  end

  def unregistered
    gems - registered.map(&:name)
  end

  private

  def scan_gems(gemfile)
    gemfile.scan(/^[ \t]*gem\s+['"](\S+)['"]/).flatten
  end
end
