class GemfileParser
  def initialize(gemfile)
    @gemfile = gemfile
  end

  GEM_REGEXP = /^[ \t]*gem\s+['"](\S+)['"]/

  def gems
    @gemfile.scan(GEM_REGEXP).flatten
  end
end
