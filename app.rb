require "cuba"
require "cuba/mote"
require "ohm"
require "ohm/json"
require "ohm/timestamps"
require "scrivener"

REDIS_URL = ENV.fetch("REDIS_URL")

Ohm.redis = Redic.new(REDIS_URL)

Dir["./lib/**/*.rb"].each     { |f| require f }
Dir["./models/**/*.rb"].each  { |f| require f }
Dir["./helpers/**/*.rb"].each { |f| require f }
Dir["./routes/**/*.rb"].each  { |f| require f }

Cuba.plugin(Cuba::Mote)
Cuba.plugin(HtmlHelper)
Cuba.plugin(RoutesHelper)

Cuba.define do
  on root do
    res.redirect("/gems")
  end

  on "gems" do
    run(Gems)
  end

  on "gemfile" do
    run(Gemfiles)
  end

  on default do
    not_found
  end
end
