ENV["REDIS_URL"] = "redis://localhost:6379/3"

require "cuba/test"
require_relative "../app"

prepare do
  Ohm.flush
end
