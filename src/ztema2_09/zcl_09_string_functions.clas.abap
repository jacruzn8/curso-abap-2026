**********************************************************************
* Link al ejercicio: https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/processing-strings-using-functions-and-regular-expressions_abe828f3-4e84-45ce-9c39-0cf9eb2a9f2f
**********************************************************************

CLASS zcl_09_string_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_STRING_FUNCTIONS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA text TYPE string VALUE `Let's talk about ABAP `.
  DATA result TYPE i.

  out->write( text ).

  result = find( val = text sub = 'A' ).
  out->write( | El resultado de 1 es; {  result } | ).


  result = find( val = text sub = 'A' case = abap_false ).
  out->write( |El resultado de 2 es: { result } | ).

  result = find( val = text sub = 'A' case = abap_false occ = -1 ).
  out->write(  |El resultado de 3 es: { result } | ).

  result = find( val = text sub = 'A' case = abap_false occ = -2 ).
  out->write(  |El resultado de 4 es: { result } | ).

  result = find( val = text sub = 'A' case = abap_false occ = 2 ).
  out->write(  |El resultado de 5 es: { result } | ).

  result = find( val = text sub = 'A' case = abap_false occ = 2 off = 10 ).
  out->write(  |El resultado de 6 es: { result } | ).

  result = find( val = text sub = 'A' case = abap_false occ = 2 off = 10 len = 4 ).
  out->write(  |El resultado de 7 es: { result } | ).


  ENDMETHOD.
ENDCLASS.
