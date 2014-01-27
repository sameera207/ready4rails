require "cuba"
require "cuba/mote"
require "ohm"
require "ohm/json"
require "ohm/timestamps"
require "rack/protection"
require "requests"
require "scrivener"

APP_SECRET = ENV.fetch("APP_SECRET")
GITHUB_CLIENT_ID = ENV.fetch("GITHUB_CLIENT_ID")
GITHUB_CLIENT_SECRET = ENV.fetch("GITHUB_CLIENT_SECRET")
GITHUB_OAUTH_AUTHORIZE = ENV.fetch("GITHUB_OAUTH_AUTHORIZE")
GITHUB_OAUTH_ACCESS_TOKEN = ENV.fetch("GITHUB_OAUTH_ACCESS_TOKEN")
GITHUB_FETCH_USER = ENV.fetch("GITHUB_FETCH_USER")
REDIS_URL = ENV.fetch("REDIS_URL")

Ohm.redis = Redic.new(REDIS_URL)

Dir["./lib/**/*.rb"].each     { |f| require f }
Dir["./models/**/*.rb"].each  { |f| require f }
Dir["./helpers/**/*.rb"].each { |f| require f }
Dir["./filters/**/*.rb"].each { |f| require f }
Dir["./routes/**/*.rb"].each  { |f| require f }

Cuba.plugin(Cuba::Mote)
Cuba.plugin(HtmlHelper)
Cuba.plugin(RoutesHelper)

Cuba.use(Rack::Session::Cookie, key: "ready4rails", secret: APP_SECRET)
Cuba.use(Rack::Protection)
Cuba.use(Rack::Protection::RemoteReferrer)

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
