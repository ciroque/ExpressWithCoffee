logging = require('../../core/Logger')
RouteProvider = require('../../core/RouteProvider')

class RouteTwo extends RouteProvider.RouteProvider
  constructor: (opts) ->
    super()
    @path = "/TWO"
    @logger = opts.logger || new logging.Logger()

module.exports = {
  RouteTwo: RouteTwo
}
