class RubyGem < Ohm::Model
  include Ohm::Timestamps

  attribute :name
  attribute :status
  attribute :notes

  index :name
  index :status

  STATUSES = ["ready", "not ready", "unknown"]

  def self.recent
    all.sort_by(:updated_at, order: "ALPHA DESC", limit: [0, 25])
  end

  def self.fetch_by(att, val)
    keys = to_indices(att, val)
    command = Ohm::Command.new(:sunionstore, *keys)

    Ohm::MultiSet.new(key, self, command)
  end
end
