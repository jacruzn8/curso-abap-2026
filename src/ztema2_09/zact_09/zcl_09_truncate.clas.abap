CLASS zcl_09_truncate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_TRUNCATE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

DATA long_char TYPE c LENGTH 10.
DATA short_char TYPE c LENGTH 5.


DATA result TYPE p LENGTH 3 DECIMALS 2.
DATA result2 TYPE p LENGTH 3 decimals 4.


result = 1 / 8.
result2 = 1 / 8.


out->write( |1 / 8 is rounded to { result NUMBER = USER }| ).
out->write( |1 / 8 is equal to { result2 NUMBER = USER }| ).

  ENDMETHOD.
ENDCLASS.
