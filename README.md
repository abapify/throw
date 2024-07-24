# Throw an exception
Throw an exception in a minimalistic way

Here is the idea

we should be able to do something like:
```abap
throw( 'Something bad happened' )
```

adn it should raise us the static exception. That's it

## Implementation

It will be delivered as the interface `ZIF_THROW` which you can implement in your class or the class `ZCL_THROW` which you can inherit from.
