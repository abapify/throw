*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class lcx_sy definition inheriting from cx_static_check.
  public section.
    interfaces if_t100_message.
    types:
      begin of attrs_ts,
        msgv1 type sy-msgv1,
        msgv2 type sy-msgv2,
        msgv3 type sy-msgv3,
        msgv4 type sy-msgv4,
      end of attrs_ts,
      begin of message_ts,
        msgid type sy-msgid,
        msgno type sy-msgno.
        include type attrs_ts as _attrs.
      types:
      end of message_ts.
    data message type message_ts read-only.
    data data type ref to data read-only.
    methods constructor
      importing
        previous       type ref to cx_root optional
        value(message) type message_ts optional
        data           type any.
  private section.

endclass.

class lcx_sy implementation.

  method constructor.

    if message is initial.
      message = corresponding message_ts( sy ).
    endif.

    super->constructor( previous = previous ).

    me->message = message.

    me->if_t100_message~t100key = value #(
      msgid = message-msgid
      msgno = message-msgno
      attr1 = 'MESSAGE-MSGV1'
      attr2 = 'MESSAGE-MSGV2'
      attr3 = 'MESSAGE-MSGV3'
      attr4 = 'MESSAGE-MSGV4'
    ).

    create data me->data like data.
    assign me->data->* to field-symbol(<data>).
    <data> = data.

  endmethod.

endclass.

class lcx_text definition inheriting from lcx_sy.
  public section.
    methods constructor importing
                          previous type ref to cx_root optional
                          message  type csequence.
endclass.

class lcx_text implementation.
  method constructor.

    data(attrs) = conv attrs_ts( message ).

    message s000(zthrow) with attrs-msgv1 attrs-msgv2 attrs-msgv3 attrs-msgv4 into data(lv_dummy).

    super->constructor(
      previous = previous
      data = message
    ).

  endmethod.
endclass.

class lcl_rtts definition abstract.
  public section.

    class-methods applies_to_csequence
    importing data type any
    returning value(result) type abap_bool.

  private section.

    class-methods get_csequence_type returning value(result) type ref to cl_abap_elemdescr.
endclass.

class lcl_rtts implementation.
  method get_csequence_type.
    statics csequence_type type ref to cl_abap_elemdescr.
    if csequence_type is not bound.
*      csequence_type = cast #(  cl_abap_typedescr=>describe_by_data( csequence ) ).
      csequence_type = cast #(  cl_abap_typedescr=>describe_by_name( 'CSEQUENCE' ) ).
    endif.
    result = csequence_type.
  endmethod.

  method applies_to_csequence.
    result = get_csequence_type( )->applies_to_data( p_data = data ).
  endmethod.
endclass.
