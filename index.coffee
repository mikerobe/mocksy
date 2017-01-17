_ = require 'lodash'

module.exports = mocksy =
  mock: ->
    calls = []
    returnValue = undefined

    fn = ->
      fn.calls.push arguments
      returnValue

    Object.defineProperty fn, 'called',
      configurable: false
      enumerable: false
      get: -> calls.length > 0

    Object.defineProperty fn, 'calledOnce',
      configurable: false
      enumerable: false
      get: -> calls.length is 1

    Object.defineProperty fn, 'notCalled',
      configurable: false
      enumerable: false
      get: -> calls.length is 0

    fn.calledWith = ->
      for call in calls
        return true if _.isEqual call, arguments
      false

    fn.calls = calls

    fn.returns = (value) ->
      returnValue = value
      fn

    fn
