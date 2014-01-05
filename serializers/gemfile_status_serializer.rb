class GemfileStatusSerializer < JsonSerializer
  attribute :registered, :RubygemSerializer
  attribute :unregistered
end
