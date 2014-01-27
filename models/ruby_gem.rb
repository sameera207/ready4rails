class RubyGem < Ohm::Model
  include Ohm::Timestamps

  STATUSES = %w(ready not_ready unknown)

  attribute :name
  attribute :status
  attribute :notes

  index :name
  index :status

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

  def to_hash
    super.merge!(name: name, status: status, notes: notes)
  end
end
