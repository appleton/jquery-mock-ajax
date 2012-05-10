# Mock GET responses
# Add a new key for each mock URL

define ->
  {
    'ajax/response/path/1': 'Data to be returned'
    'ajax/response/path/2': {
      we: 'can'
      also: 'return'
      JSON: 'too'
    }
  }

