class zcl_throw definition
  public
  final
  create public .

  public section.
  interfaces zif_throw.
  aliases throw for zif_throw~throw.
  protected section.
  private section.
endclass.

class zcl_throw implementation.
  method zif_throw~throw.

    if message is not initial.
        raise exception type lcx_text
          exporting
*            previous =
            message  = message
        .
    endif.

    " fallback scenario to raise generic exception
    " it will also inherit system message
    raise exception type lcx_sy.

  endmethod.

endclass.
