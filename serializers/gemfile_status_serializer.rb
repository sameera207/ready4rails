class GemfileStatusSerializer < JsonSerializer
  attribute :registered, :RubyGemSerializer
  attribute :unregistered
end
