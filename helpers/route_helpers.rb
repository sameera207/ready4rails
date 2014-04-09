module Helpers
  module RouteHelpers
    def not_found
      res.status = 404

      halt(res.finish)
    end
  end
end
