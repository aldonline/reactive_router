
```coffeescript

router = require 'reactive_hash_querystring_router'

router() # returns an object with all the qs params. reactive.

router('a') # returns a read-only reactive cell connected to the value of a

router( 'a=b&c=d' ) # sets the new querystring

router( a:'b', c:'d' ) # same as above

```