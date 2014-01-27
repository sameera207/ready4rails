class Gemfiles < Cuba
  plugin GemfilesHelper

  define do
    on get, root do
      render("gemfile", gemfile: nil)
    end

    on post, param("gemfile") do |gemfile|
      gems = GemfileParser.new(gemfile).gems

      on !gems.empty? do
        status = GemfileStatus.new(gems)
        registered = status.registered
        unregistered = status.unregistered

        on accept("application/json") do
          json(registered: registered, unregistered: unregistered)
        end

        on default do
          render("gemfile/status", registered: registered, unregistered: unregistered)
        end
      end

      on default do
        render("gemfile", gemfile: gemfile)
      end
    end

    on default do
      not_found
    end
  end
end
