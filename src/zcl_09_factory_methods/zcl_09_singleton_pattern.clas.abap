CLASS zcl_09_singleton_pattern DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_SINGLETON_PATTERN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connection type REF to lcl_connection.

*Debug method to show that the class always returns same object for the same combination of airline & fight

connection = lcl_connection=>get_connection(  airlineid = 'LH' connectionnumber = '0400' ).

connection = lcl_connection=>get_connection(  airlineid = 'UA' connectionnumber = '0800' ).

connection = lcl_connection=>get_connection(  airlineid = 'LH' connectionnumber = '0400' ).

connection = lcl_connection=>get_connection(  airlineid = 'UA' connectionnumber = '0800' ).

  ENDMETHOD.
ENDCLASS.
