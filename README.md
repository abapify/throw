# Throw anything as exception
Throw any object as exception in a minimalistic way. The prototype for this class is native javascript [throw](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/throw).

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

## Usage

### Via static method

```abap
zcl_throw=>from( 'Error happenned' ).
```
or 
```abap
message e001(zmy_message_class) with 'this` 'and' 'that' into data(lv_dummy).
zcl_throw=>from( ).
```

### Via instance 

Not sure if we even need this way, may be for extensions with inherited classes

```abap
new zcl_throw( )->throw( 'Error happenned' ).
```
or 
```abap
message e001(zmy_message_class) with 'this` 'and' 'that' into data(lv_dummy).
new zcl_throw( )->throw( ).
```

### Via interface 

You can also implement `ZIF_THROW` interface in your class or just inherit from `ZCL_THROW` class

In short here is the pattern how you can use it:
```abap
class zcl_your_class definition.
  public section.
    interfaces zif_throw.    
  private section.
    aliases throw for zif_throw~throw.
    methods do_something raising cx_static_check.
endclass.
class zcl_your_class implementation.
  method zif_throw~throw.
    zcl_throw=>from( object ).
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
