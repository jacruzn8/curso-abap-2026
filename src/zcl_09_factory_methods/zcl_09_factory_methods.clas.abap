CLASS zcl_09_factory_methods DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_FACTORY_METHODS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

data connection TYPE REF to lcl_connection.
DATA: connection2 TYPE REF TO lcl_connection.

* Debug the method to show that the class return objects, but that there are different
* objects for the same combination of airline and flight number.


connection = lcl_connection=>get_connection(  airlineid = 'LH' connectionnumber = '0400' ).

out->write( connection ).

connection2 = lcl_connection=>get_connection(  airlineid = 'UA' connectionnumber = '0800' ).
out->write( connection2 ).

ENDMETHOD.
ENDCLASS.
