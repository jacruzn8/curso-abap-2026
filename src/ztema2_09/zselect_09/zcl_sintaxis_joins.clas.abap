CLASS zcl_sintaxis_joins DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SINTAXIS_JOINS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    select from /dmo/carrier inner join /dmo/connection
    on /dmo/carrier~carrier_id = /dmo/connection~carrier_id
    fields /dmo/carrier~carrier_id,
           /dmo/carrier~name as carrier_namem,
           /dmo/connection~connection_id,
           /dmo/connection~airport_from_id,
           /dmo/connection~airport_to_id

     where /dmo/carrier~currency_code = 'EUR'
     into table @data(result).

     out->write(
            exporting
            data = result
            name = 'RESULT'
     ).


  ENDMETHOD.
ENDCLASS.
