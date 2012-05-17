(function() {
  define(function(require) {
    var $, mockAjax, realAjax, responses, self;
    $ = require('jquery');
    responses = {
      'GET': require('responses/get'),
      'POST': require('responses/post'),
      'PUT': require('responses/put'),
      'DELETE': require('responses/delete')
    };
    realAjax = $.ajax;
    mockAjax = function(opts) {
      var response, status, _ref;
      opts.type || (opts.type = 'GET');
      if (opts.data) {
        opts.url += "?" + ($.param(opts.data));
      }
      response = (_ref = responses[opts.type]) != null ? _ref[opts.url] : void 0;
      status = response ? 'success' : 'error';
      if (response) {
        if (typeof opts.success === "function") {
          opts.success(response);
        }
      } else {
        if (typeof opts.error === "function") {
          opts.error({}, 'error', 'Not Found');
        }
      }
      return typeof opts.complete === "function" ? opts.complete({}, status) : void 0;
    };
    self = {
      mock: function() {
        return $.ajax = mockAjax;
      },
      restore: function() {
        return $.ajax = realAjax;
      }
    };
    return self;
  });
}).call(this);
