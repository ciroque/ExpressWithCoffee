logging = require('../../core/Logger')
RouteProvider = require('../../core/RouteProvider')

class RouteTwo extends RouteProvider.RouteProvider
  constructor: (opts) ->
    super()
    @path = "/TWO"
    @logger = opts.logger || new logging.Logger()

#  retrieveRoutes: (routes) ->
#    @logger.debug("RouteTwo::retrieveRoutes")
#    routes.push("Two:One")
#    routes.push("Two:Two")

module.exports = {
  RouteTwo: RouteTwo
}
