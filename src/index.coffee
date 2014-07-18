reactivity = require 'reactivity'

interval = -> setInterval arguments[1], arguments[0]
delay    = -> setTimeout arguments[1], arguments[0]
euc = (v) -> encodeURIComponent v
duc = (v) -> decodeURIComponent v

stringify = ( params ) -> ( ( euc(k) + '=' + euc(v) ) for own k, v of params ).join '&'

parse = ( qs ) ->
  params = {}
  qs ?= ''
  for pair in qs.split '&' when pair isnt ''
    [name, value] = pair.split '='
    params[duc name] = duc value
  params

# we use plain old polling here
hash_ = reactivity window.location.hash
interval 100, => hash_ window.location.hash

hash_qs = ->
  try
    hash_().split('?')[1]
  catch e
    ''

qs_params = -> parse hash_qs()

key_cells = {}

###
qs() returns an object with all the qs params. reactive.
qs('a') returns a read-only cell connected to the value of a
qs( 'a=b&c=d' ) sets the new querystring
qs( a:'b', c:'d' ) same as above
###
main = ->
  # TODO: sort param names to generate a canonical string
  a = arguments
  if a.length is 1 # set
    x = a[0]
    if typeof x is 'string' and x.indexOf('=') is -1
      key_cells[x] ?= do ->
        cell = reactivity()
        reactivity.subscribe qs_params, ( e, r ) -> cell r[x]
        cell
    else # set
      new_value = a[0]
      new_value = stringify new_value if typeof new_value is 'object'
      window.location.hash = '?' + new_value
  else # get
    qs_params()

module.exports = main