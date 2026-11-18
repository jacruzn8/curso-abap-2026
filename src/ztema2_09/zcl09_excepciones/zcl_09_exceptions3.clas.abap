CLASS zcl_09_exceptions3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_EXCEPTIONS3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


DATA connection TYPE REF TO lcl_connection.
DATA exception TYPE REF TO lcx_no_connection.

TRY.
    connection = NEW #( i_airlineid = 'XX' i_connectionnumber = '0000' ).
  CATCH lcx_no_connection INTO exception.
    out->write( exception->get_text( ) ).
ENDTRY.

  ENDMETHOD.
ENDCLASS.
