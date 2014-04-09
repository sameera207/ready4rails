class RubyGem < Sequel::Model
  plugin(:timestamps, update_on_create: true)

  STATUSES = %w(ready not_ready unknown)

  def self.search(name)
    where(Sequel.ilike(:name, name))
  end

  def self.recent
    order(:updated_at).offset(0).limit(25)
  end

  def to_hash
    super.merge!(name: name, status: status, notes: notes)
  end
end
