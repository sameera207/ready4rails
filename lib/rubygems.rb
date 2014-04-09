require "net/http"

module Rubygems
  URL = "https://rubygems.org/api/v1/gems/%s.json"

  def self.exists?(name)
    uri = URI(sprintf(URL, name))
    res = Net::HTTP.get_response(uri)

    res.code == "200"
  end
end
