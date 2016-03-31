"use strict";

chai = require('chai')
routeRegistrar = require('../core/RouteRegistrar')

expect = chai.expect

class MockApp
  constructor: () ->
    @routes = []

  registerRoute: (route) ->
    @routes.push(route)

  getRouteCount: ->
    @routes.length

describe 'RouteRegistrar', ->
  registrar = new routeRegistrar.RouteRegistrar()

  fs = require('fs')
  pathToTestRoutes = "#{__dirname}/test-routes"

  before(() ->
    @files = fs.readdirSync(pathToTestRoutes).filter((filename) -> /\.js$/.test(filename))
  )

  describe 'findModules', ->
    it 'should find the route files given a directory', (done) ->
      registrar.findModules(__dirname + '/test-routes', (err, result) ->
        expect(err).to.equal null
        expect(result.files.length).to.equal 3
        done()
      )

    it 'should return an error when the directory does not exist', (done) ->
      registrar.findModules(__dirname + '/DOESNOTEXIST', (err, result) ->
        expect(result.files).to.equal undefined
        expect(err.message).to.contain('DOESNOTEXIST')
        expect(err.message).to.contain('NOENT')
        done()
      )

  describe 'retrieveRoutesFromModules', ->
    fs = require('fs')
    pathToTestRoutes = "#{__dirname}/test-routes"

    before(() ->
      @files = fs.readdirSync(pathToTestRoutes).filter((filename) -> /\.js$/.test(filename))
    )

    it 'should build a list of all the routes in all the modules', (done) ->
      modules = { path: pathToTestRoutes, files: @files }
      registrar.retrieveRoutesFromModules(modules, (err, routes) ->
        expect(err).to.equal null
        expect(routes.length).to.equal 3
        done()
      )

#  describe 'registerRoutesWithApp', ->
#    it 'registers all the discovered routes with the given App instance', (done) ->
#      mockApp = new MockApp()
#      routes = []
#      registrar.registerRoutesWithApp(mockApp, routes, (err) ->
#        expect(err).to.equal null
#        expect(mockApp.getRouteCount()).to.equal 7
#        done()
#      )