*"* use this source file for your ABAP unit test classes
class ltcl_throw definition final for testing inheriting from zcl_assertable_unit
  duration short
  risk level harmless.

  public section.

    interfaces zif_throw.
    aliases throw for zif_throw~throw.

  private section.
    methods:
      cx_sy for testing raising cx_static_check,
      cx_txt for testing raising cx_static_check.
endclass.


class ltcl_throw implementation.

  method zif_throw~throw.
    new zcl_throw( )->throw( message ).
  endmethod.

  method cx_sy.

     try.
        message s000(zthrow) into data(lv_dummy) with 'A' 'B' 'C' 'D'.
        throw( ).
     catch lcx_sy into data(lo_cx).
        assert( lo_cx->get_text(  ) )->eq( 'ABCD' ).
     endtry.

     assert( lo_cx )->bound( ).

  endmethod.

  method cx_txt.

     data(message) = conv string( sy-abcde ).

     try.
       throw( message ).
     catch lcx_text into data(lo_cx).
        assert( lo_cx->get_text(  ) )->eq( message ).
     endtry.

     assert( lo_cx )->bound( ).

  endmethod.

endclass.
