"use strict";

express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
logging = require('./core/Logger')

class Application
  constructor: () ->
    @application = express()
    @logger = new logging.Logger()

  initializeErrorHandling: () ->
    @logger.debug('Application::initializeErrorHandling')
    @application.use((err, req, res, next) ->
      err = new Error('Not Found')
      err.status = 404
      next(err)
    )

    if @application.get('env') == 'development'
      @application.use((err, req, res, next) ->
        res.status(err.status || 500)
        res.render('error', {
          message: err.message,
          error: err
        })
      )

    @application.use((err, req, res, next) ->
      res.status(err.status || 500)
      res.render('error', {
        message: err.message,
        error: {}
      })
    )

  initializeLogging: () ->
    @logger.debug('Application::initializeLogging')
    @application.use(logger('dev'))

  initializeParsers: () ->
    @logger.debug('Application::initializeParsers')
    @application.use(bodyParser.json())
    @application.use(bodyParser.urlencoded({extended: false}))
    @application.use(cookieParser())

  initializeProcessors: () ->
    @logger.debug('Application::initializeProcessors')
    rootPath = __dirname
    publicPath = 'public'
    @application.use(require('node-sass-middleware')({
      src: path.join(rootPath, publicPath),
      dest: path.join(rootPath, publicPath),
      indentedSyntax: true,
      sourceMap: true
    }))

  initializeRoutes: () ->
    @logger.debug('Application::initializeRoutes')
    selfLogger = @logger
    selfApp = @application
    routeRegistrar = require('./core/RouteRegistrar')
    registrar = new routeRegistrar.RouteRegistrar()
    registrar.findModules("#{__dirname}/routes", (err, dirInfo) ->
      selfLogger.debug('Application::initializeRoutes registrar.findModules')
      registrar.retrieveRoutesFromModules(dirInfo, (err, routes) ->
        selfLogger.debug("Application::initializeRoutes -> registrar.findModules -> registrar.retrieveRoutesFromModules #{JSON.stringify(routes)}")
        selfApp.use(route.path, route.handler.router) for route in routes
      )
    )

  initializeStatics: () ->
    @logger.debug('Application::initializeStatics')
    bootstrapPath = "#{__dirname}/node_modules/bootstrap/dist"
    @application.use(express.static(path.join(__dirname, 'public')))
    @application.use('/bootstrap', express.static(bootstrapPath))

  initializeViewEngine: () ->
    @logger.debug('Application::initializeViewEngine')
    @application.set('views', path.join(__dirname, 'views'))
    @application.set('view engine', 'jade')

  initialize: () ->
    @logger.debug('Application::initialize')
    @initializeLogging()
    @initializeViewEngine()
    @initializeParsers()
    @initializeProcessors()
    @initializeStatics()
    @initializeRoutes()
    @initializeErrorHandling()
    @

app = new Application()
app.initialize()

module.exports = app.application
