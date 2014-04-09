require "cuba"
require "cuba/mote"
require "ohm"
require "ohm/json"
require "ohm/timestamps"
require "rack/protection"
require "scrivener"

APP_SECRET = ENV.fetch("APP_SECRET")
REDIS_URL = ENV.fetch("REDIS_URL")

Ohm.redis = Redic.new(REDIS_URL)

Cuba.plugin(Cuba::Mote)

Dir["./models/**/*.rb"].each  { |f| require f }
Dir["./helpers/**/*.rb"].each { |f| require f }
Dir["./filters/**/*.rb"].each { |f| require f }
Dir["./routes/**/*.rb"].each  { |f| require f }

Cuba.plugin(HtmlHelper)
Cuba.plugin(RoutesHelper)

Cuba.use(Rack::Session::Cookie, key: "ready4rails", secret: APP_SECRET)
Cuba.use(Rack::Protection)
Cuba.use(Rack::Protection::RemoteReferrer)
Cuba.use(Rack::Static, urls: ["css"], root: "./public")

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
