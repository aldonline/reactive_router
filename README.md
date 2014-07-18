```coffeescript

router = require 'reactive_router'

router()             # returns an object with all the qs params. this function is reactive.

router 'a'           # returns a read-only reactive cell connected to the value of a

router 'a=b&c=d'     # sets the new querystring

router a:'b', c:'d'  # same as above

```