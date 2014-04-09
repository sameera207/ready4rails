require "cuba"
require "cuba/mote"
require "hache"
require "rack/protection"
require "scrivener"
require "sequel"

APP_KEY = ENV.fetch("APP_KEY")
APP_SECRET = ENV.fetch("APP_SECRET")
DATABASE_URL = ENV.fetch("DATABASE_URL")

Sequel.connect(DATABASE_URL)

Cuba.plugin(Cuba::Mote)

Cuba.use(Rack::Session::Cookie, key: APP_KEY, secret: APP_SECRET)
Cuba.use(Rack::Static, urls: ["css"], root: "./public")

Cuba.use(Rack::Protection)
Cuba.use(Rack::Protection::RemoteReferrer)

Dir["./models/**/*.rb"].each  { |f| require(f) }
Dir["./filters/**/*.rb"].each { |f| require(f) }
Dir["./helpers/**/*.rb"].each { |f| require(f) }
Dir["./routes/**/*.rb"].each  { |f| require(f) }

Cuba.plugin(Helpers::HTMLHelpers)
Cuba.plugin(Helpers::RouteHelpers)

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
