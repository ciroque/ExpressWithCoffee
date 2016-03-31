logging = require('../../core/Logger')
RouteProvider = require('../../core/RouteProvider')

class RouteThree extends RouteProvider.RouteProvider
  constructor: (opts) ->
    super()
    @path = "/THREE"
    @logger = opts.logger || new logging.Logger()

module.exports = {
  RouteThree: RouteThree
}
