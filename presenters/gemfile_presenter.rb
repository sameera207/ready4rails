class GemfilePresenter
  def initialize(gemfile)
    @gemfile = gemfile
  end

  def registered
    @gemfile.registered
  end

  def unregistered
    @gemfile.unregistered
  end

  def unregistered_links
    new_gem_links(unregistered).join(", ")
  end

  private

  def new_gem_links(names)
    names.map do |name|
      "<a href=\"/gems/new?name=#{name}\">#{name}</a>"
    end
  end
end
