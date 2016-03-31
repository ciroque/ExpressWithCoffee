
logging = require('../../source/core/Logger')
RouteProvider = require('../../source/core/RouteProvider')

class RouteOne extends RouteProvider.RouteProvider
  constructor: (opts) ->
    super()
    @path = "/ONE"
    @logger = opts.logger || new logging.Logger()

#  retrieveRoutes: (routes) ->
#    @logger.debug("RouteOne::retrieveRoutes")
#    routes.push("One:One")
#    routes.push("One:Two")
#
module.exports = {
  RouteOne: RouteOne
}
