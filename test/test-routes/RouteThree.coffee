logging = require('../../core/Logger')
RouteProvider = require('../../core/RouteProvider')

class RouteThree extends RouteProvider.RouteProvider
  constructor: (opts) ->
    super()
    @path = "/THREE"
    @logger = opts.logger || new logging.Logger()

#  retrieveRoutes: (routes) ->
#    @logger.debug("RouteThree::retrieveRoutes")
#    routes.push("Three:One")
#    routes.push("Three:Two")
#    routes.push("Three:Three")

module.exports = {
  RouteThree: RouteThree
}
