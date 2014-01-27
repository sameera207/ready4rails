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

  def self.fetch_by_name(names)
    names = names.dup
    result = find(name: names.pop)

    names.each do |name|
      result = result.union(name: name)
    end

    result
  end
end
