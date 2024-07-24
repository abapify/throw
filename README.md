# Throw an exception
Throw an exception in a minimalistic way

Here is the idea

we should be able to do something like:
```abap
throw( 'Something bad happened' )
```
or even 
```abap
message e001(zmy_message_class) with 'this` 'and' 'that' into data(lv_dummy).
throw( ).
```

In both cases we expect a static exception should be raised with a text message from a given text or just inherited from a system message.
That's it.

## Implementation

It will be delivered as the interface `ZIF_THROW` which you can implement in your class or the class `ZCL_THROW` which you can inherit from.

In short here is the pattern how you can use it:
```abap
class zcl_your_class definition.
  public section.
    interfaces zif_throw.    
  private section.
    aliases throw for zif_throw~throw.
    methods do_something.
endclass.
class zcl_your_class implementation.
  method zif_throw~throw.
    new zcl_throw( )->throw( message ).
  endmethod.
  method do_something.
    if something_bad_happened( ).
      throw( 'Something bad happened' ).
    endif.
  endmethod.
endclass.
```

# Dependencies
- [assert](https://github.com/abapify/assert) is used in unit tests for throw
