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
    to_sentence(new_gem_links)
  end

  private

  def new_gem_links
    @gemfile.unregistered.map do |name|
      "<a href=\"/gems/new?name=#{name}\">#{name}</a>"
    end
  end

  def to_sentence(items)
    "#{ items[0...-1].join(", ") } and #{ items[-1] }"
  end
end
