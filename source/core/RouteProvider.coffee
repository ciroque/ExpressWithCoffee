"use-strict"

express = require('express');

class RouteProvider
  constructor: () ->
    @router = express.Router()
    @path = ''

module.exports = {
  RouteProvider: RouteProvider
}
