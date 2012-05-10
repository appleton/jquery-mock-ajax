# Mock jQuery AJAX calls

Provides a simple function to override jQuery.ajax. Handy for writing tests.

This assumes [Require.js](http://require.js) or a similar AMD script loader is
being used. Written in CoffeeScript but the compiled JavaScript is also
included.

##Usage
Set up mock responses by adding keys to the objects in `responses/get.coffee`,
`responses/post.coffee`, `responses/put.coffee` and `responses/delete.coffee`.

Load the module into the page:

`var ajax = require('path/to/ajax');`

Replace jQuery.ajax with the mock function:

`ajax.mock();`

Restore the original jQuery.ajax method:

`ajax.restore();`

## Methods
###`mock`
Replace jQuery.ajax with the mock function

###`restore`
Restore jQuery.ajax to it's original state

## Example
I use this with [Jasmine](https://github.com/pivotal/jasmine), but there's no
reason it can't be used elsewhere. Here's a complete example test wrapped as an
AMD module (I like AMD, can you tell?):


    define(function(require){
      var ajax = require('path/to/ajax');

      describe(function(){

        beforeEach(function(){
          ajax.mock();
        });

        afterEach(function(){
          ajax.restore();
        });

        it('Should be awesome', function(){
          $.ajax({
            url: 'sausages',
            success: function(){},
            error: function(){};
          });
        });

      });
    });
