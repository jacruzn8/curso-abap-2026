**********************************************************************
* Link al ejercicio
* https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/processing-strings-using-functions-and-regular-expressions_abe828f3-4e84-45ce-9c39-0cf9eb2a9f2f
**********************************************************************

CLASS zcl_09_example_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_EXAMPLE_FUNCTIONS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA result TYPE i.
  DATA text   TYPE string VALUE `  ABAP  `.
  DATA substring TYPE string VALUE `AB`.
  DATA offset  TYPE i value 1.

* Call Different description functions

 result = strlen( text ).
 out->write( | ` El resultado de 1 es ` { result } | ).

 result = numofchar(  text ).
 out->write( | ` El resultado de 2 es ` { result } | ).

 result = count(  val = text sub = substring off = offset ).
out->write( | ` El resultado de 3 es ` { result } | ).


    result = find(             val = text sub = substring off = offset ).
out->write( | ` El resultado de 3 es ` { result } | ).


    result = count_any_of(     val = text sub = substring off = offset ).
out->write( | ` El resultado de 3 es ` { result } | ).

    result = find_any_of(      val = text sub = substring off = offset ).
out->write( | ` El resultado de 3 es ` { result } | ).

    result = count_any_not_of( val = text sub = substring off = offset ).
out->write( | ` El resultado de 3 es ` { result } | ).

    result = find_any_not_of(  val = text sub = substring off = offset ).
out->write( | ` El resultado de 3 es ` { result } | ).

    out->write( |Text      = `{ text }`| ).
    out->write( |Substring = `{ substring }` | ).
    out->write( |Offset    = { offset } | ).
    out->write( |Result    = { result } | ).





  ENDMETHOD.
ENDCLASS.
