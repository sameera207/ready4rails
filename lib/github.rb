module GitHub
  include Requests

  def self.fetch_access_token(code)
    data = { client_id: GITHUB_CLIENT_ID, client_secret: GITHUB_CLIENT_SECRET, code: code }
    headers = { "Accept" => "application/json" }

    req = request("POST", GITHUB_OAUTH_ACCESS_TOKEN, data: data, headers: headers)

    req.json["access_token"]
  end

  def self.fetch_user(token)
    request("GET", GITHUB_FETCH_USER, params: { access_token: token }).json
  end

  def self.oauth_authorize_url
    "#{GITHUB_OAUTH_AUTHORIZE}?client_id=#{GITHUB_CLIENT_ID}"
  end
end
