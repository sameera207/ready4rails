module Ohm
  class BasicSet
    # Fetches with multiple attribute values.
    #
    #   class RubyGem < Ohm::Model
    #     attribute :name
    #     attribute :status
    #
    #     index :name
    #     index :status
    #   end
    #
    #   RubyGem.create(name: "cuba", status: "ready")
    #   RubyGem.create(name: "mote", status: "not ready")
    #   RubyGem.create(name: "pry",  status: "unknown")
    #
    #   Rubygem.fetch_by(status: ["ready", "unknown"]).map(&:name)
    #   # => ["cuba", "pry"]
    #
    #   Rubygem.create(name: "ohm", status: "ready")
    #   Rubygem.create(name: "ohm-contrib", status: "ready")
    #
    #   Rubygem.find(status: "ready").fetch_by(name: ["cuba", "ohm"]).map(&:name)
    #   # => ["cuba", "ohm"]
    #
    #   Rubygem.fetch_by(status: ["ready", "unknown"]).except(name: "cuba").map(&:name)
    #   # => ["ohm", "ohm-contrib"]
    #
    def fetch_by(att, val)
      keys = model.to_indices(att, val)
      command = Ohm::Command.new(:sunionstore, *keys)

      Ohm::MultiSet.new(namespace, model, command)
    end
  end

  class Model
    # Fetches with multiple attribute values.
    #
    #   class RubyGem < Ohm::Model
    #     attribute :name
    #     attribute :status
    #
    #     index :name
    #   end
    #
    #   RubyGem.create(name: "cuba", status: "ready")
    #   RubyGem.create(name: "mote", status: "ready")
    #
    #   result =RubyGem.fetch_by(:name, ["cuba", "mote"]
    #
    #   result.map(&:status)
    #   # => ["ready", "ready"]
    #
    def self.fetch_by(att, val)
      all.fetch_by(att, val)
    end
  end
end
