"use strict"

chai = require('chai')
loggingSink = require('./TestLoggingSink')
logging = require('../source/core/Logger')

expect = chai.expect

describe 'Logger', ->
  @logger = null
  @logSink = null
  TEST_MESSAGE = "TEST MESSAGE"

  beforeEach(() ->
    @logSink = new loggingSink.TestLoggingSink()
    @logger = new logging.Logger({ level: logging.LogLevel.ALL, sink: @logSink})
  )

  it 'Logs at the debug level', ->
    @logger.debug(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 1
    expect(@logSink.getEvents()[0]).to.include('DEBUG')

  it 'Logs at the error level', ->
    @logger.error(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 1
    expect(@logSink.getEvents()[0]).to.include('ERROR')

  it 'Logs at the info level', ->
    @logger.info(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 1
    expect(@logSink.getEvents()[0]).to.include('INFO')

  it 'Logs at the warn level', ->
    @logger.warn(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 1
    expect(@logSink.getEvents()[0]).to.include('WARN')

  it 'Does not log when LogLevel is NONE', ->
    logger = new logging.Logger({level: logging.LogLevel.NONE, sink: @logSink})
    logger.debug(TEST_MESSAGE)
    logger.error(TEST_MESSAGE)
    logger.info(TEST_MESSAGE)
    logger.warn(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 0

  it 'Logs only error events when LogLevel is ERROR', ->
    logger = new logging.Logger({level: logging.LogLevel.ERROR, sink: @logSink})
    logger.debug(TEST_MESSAGE)
    logger.error(TEST_MESSAGE)
    logger.info(TEST_MESSAGE)
    logger.warn(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 1

  it 'Logs only error and warn events when LogLevel is WARN', ->
    logger = new logging.Logger({level: logging.LogLevel.WARN, sink: @logSink})
    logger.debug(TEST_MESSAGE)
    logger.error(TEST_MESSAGE)
    logger.info(TEST_MESSAGE)
    logger.warn(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 2

  it 'Logs error, warn, and info events when LogLevel is INFO', ->
    logger = new logging.Logger({level: logging.LogLevel.INFO, sink: @logSink})
    logger.debug(TEST_MESSAGE)
    logger.error(TEST_MESSAGE)
    logger.info(TEST_MESSAGE)
    logger.warn(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 3

  it 'Logs error, warn, debug and info events when LogLevel is DEBUG', ->
    logger = new logging.Logger({level: logging.LogLevel.DEBUG, sink: @logSink})
    logger.debug(TEST_MESSAGE)
    logger.error(TEST_MESSAGE)
    logger.info(TEST_MESSAGE)
    logger.warn(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 4

  it 'Allows changing the Log Level', ->
    logger = new logging.Logger({level: logging.LogLevel.ALL, sink: @logSink})
    logger.debug(TEST_MESSAGE)
    logger.error(TEST_MESSAGE)
    logger.info(TEST_MESSAGE)
    logger.warn(TEST_MESSAGE)
    logger.setLogLevel(logging.LogLevel.INFO)
    logger.debug(TEST_MESSAGE)
    expect(@logSink.getEventCount()).to.equal 4