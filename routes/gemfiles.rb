class Gemfiles < Cuba
  plugin GemfilesHelper

  define do
    on get, root do
      render("gemfile", gemfile: nil)
    end

    on post, param("content") do |content|
      gemfile = Gemfile.new(content)

      on !gemfile.empty? do
        registered = gemfile.registered
        unregistered = gemfile.unregistered

        on accept("application/json") do
          json(registered: registered, unregistered: unregistered)
        end

        on default do
          render("gemfile/status", registered: registered, unregistered: unregistered)
        end
      end

      on default do
        render("gemfile", gemfile: content)
      end
    end

    on default do
      not_found
    end
  end
end
