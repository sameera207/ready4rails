class Gems < Cuba
  define do
    on get, root do
      render "gems", gems: RubyGem.recent
    end

    on "search", param("name") do |name|
      render "gems", gems: RubyGem.find(name: name)
    end

    on "new" do
      render "gems/new", gem: CreateRubyGem.new(req.params)
    end

    on "status/:status" do |status|
      gems = RubyGem.find(status: status)

      on !gems.empty? do
        render "gems", gems: gems
      end

      on default do
        not_found
      end
    end

    on post do
      on param("gem") do |params|
        gem = CreateRubyGem.new(params)

        on gem.valid? do
          RubyGem.create(gem.attributes)

          res.redirect "/gems"
        end

        on default do
          render "gems/new", gem: gem
        end
      end

      on default do
        not_found
      end
    end

    on default do
      not_found
    end
  end
end
