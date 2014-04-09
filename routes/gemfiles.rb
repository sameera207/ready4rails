class Gemfiles < Cuba
  define do
    on get, root do
      render("gemfile", gemfile: nil)
    end

    on post, param("content") do |content|
      gemfile = Gemfile.new(content)

      on !gemfile.empty? do
        render("gemfile/status", presenter: GemfilePresenter.new(gemfile))
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
