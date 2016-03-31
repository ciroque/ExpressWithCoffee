"use strict";

RouteProvider = require('../../source/core/RouteProvider')

class root  extends RouteProvider.RouteProvider
  constructor: () ->
    super()
    @router.get('', (req, res) -> res.render('index', { title: 'My Application' }); "")
    @path = '/'

module.exports = {
  root: root
}
