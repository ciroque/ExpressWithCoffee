"use strict";

RouteProvider = require('../../source/core/RouteProvider')

class about  extends RouteProvider.RouteProvider
  constructor: () ->
    super()
    @router.get('', (req, res) -> res.render('about', { title: 'My Application' }); "")
    @path = '/about'

module.exports = {
  about: about
}
