module Helpers
  module HTMLHelpers
    def h(str)
      Rack::Utils.escape_html(str)
    end
  end
end
