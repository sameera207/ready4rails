ENV["REDIS_URL"] = "redis://localhost:6379/15"

require "cuba/test"
require_relative "../app"

prepare do
  Ohm.flush
end
