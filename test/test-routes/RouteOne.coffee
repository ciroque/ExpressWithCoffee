
logging = require('../../core/Logger')
RouteProvider = require('../../core/RouteProvider')

class RouteOne extends RouteProvider.RouteProvider
  constructor: (opts) ->
    super()
    @path = "/ONE"
    @logger = opts.logger || new logging.Logger()

module.exports = {
  RouteOne: RouteOne
}
