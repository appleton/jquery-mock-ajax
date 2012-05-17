# Mock $.ajax function
#
# Runs success callback with data if found in fixtures, else runs error
# callback. Always finishes with complete callback.
#
# Exposes two methods, mock and restore. Call them to set up the fake ajax
# method and to restore the real one.


define (require) ->
  $ = require 'jquery'

  responses =
    'GET':    require('responses/get')
    'POST':   require('responses/post')
    'PUT':    require('responses/put')
    'DELETE': require('responses/delete')

  realAjax = $.ajax

  mockAjax = (opts) ->
    opts.type ||= 'GET'
    opts.url += "?#{$.param(opts.data)}" if opts.data
    response = responses[opts.type]?[opts.url]
    status = if response then 'success' else 'error'

    if response
      opts.success?(response)
    else
      opts.error?({}, 'error', 'Not Found')

    opts.complete?({}, status)

  self =
    mock:    -> $.ajax = mockAjax
    restore: -> $.ajax = realAjax

  self

