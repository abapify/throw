class zcl_throw definition
  public
  final
  create public .

  public section.
  interfaces zif_throw.
  interfaces zif_throw_static.

  aliases throw for zif_throw~throw.
  aliases from for zif_throw_static~throw.

  protected section.
  private section.

endclass.

class zcl_throw implementation.


  method zif_throw~throw.

    " raise text message
    if object is supplied
    and object is not initial
    and lcl_rtts=>applies_to_csequence( object ).

        raise exception type lcx_text
              exporting
*                previous =
                message  = object
            .

    endif.

    " fallback scenario to raise generic exception
    " it will also inherit system message
    raise exception type lcx_sy
        exporting data = object.

  endmethod.


  METHOD zif_throw_static~throw.

    new zcl_throw(  )->throw( object ).

  ENDMETHOD.

endclass.
