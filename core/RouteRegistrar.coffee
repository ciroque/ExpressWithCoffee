"use strict";

class RouteRegistrar
  constructor: (opts) ->
    @logger = opts.logger || new require('./core/Logger').Logger() if opts

  findModules: (dir, next) ->
    fs = require('fs')
    fs.readdir(dir, (err, files) ->
      if !err
        files = files.filter (filename) -> /\.js$/.test(filename)
      next(err, { path: dir, files: files })
    )

  retrieveRoutesFromModules: (modules, next) ->
    routes = []
    moduleInfos = ( { path: "#{modules.path}/#{file.slice(0, -3)}", module: file.slice(0, -3) } for file in modules.files)
    requires = ( { name: moduleInfo.module, req: require "#{moduleInfo.path}" } for moduleInfo in moduleInfos)
    handlers = (new required.req[required.name]({}) for required in requires)
    routeses = ({ path: handler.path, handler: handler, tor: typeof(handler.router) } for handler in handlers)
    routes.push(r) for r in routeses
    next(null, routes)

  registerRoutesWithApp: (app, routes, next) ->
    app.use(route.path, route.handler.router) for route in routes
    next(null)

module.exports = {
  RouteRegistrar: RouteRegistrar
}
