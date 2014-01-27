require "cuba"
require "cuba/mote"
require "json_serializer"
require "ohm"
require "ohm/timestamps"
require "scrivener"

REDIS_URL = ENV.fetch("REDIS_URL")

Cuba.plugin Cuba::Mote

Ohm.redis = Redic.new(REDIS_URL)

Dir["./lib/**/*.rb"].each         { |f| require f }
Dir["./models/**/*.rb"].each      { |f| require f }
Dir["./helpers/**/*.rb"].each     { |f| require f }
Dir["./serializers/**/*.rb"].each { |f| require f }
Dir["./routes/**/*.rb"].each      { |f| require f }

Cuba.plugin HtmlHelpers
Cuba.plugin RoutesHelpers

Cuba.define do
  on root do
    res.redirect "/gems"
  end

  on "gems" do
    run Gems
  end

  on "gemfile" do
    run Gemfiles
  end

  on default do
    not_found
  end
end
