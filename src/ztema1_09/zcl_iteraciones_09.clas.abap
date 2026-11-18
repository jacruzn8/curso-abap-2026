CLASS zcl_iteraciones_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ITERACIONES_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
* Declarations
************************************************

*  Constants c_number type i value 3.
* Constants c_number type i value 5.
  Constants c_number type i value 10.

DATA number type i.

    out->write(  `----------------------------------` ).
    out->write(  `Example 2: DO ... END             ` ).
    out->write(  `----------------------------------` ).
    out->write(  `Example 1: DO ... ENDDO with TIMES` ).
    out->write(  `----------------------------------` ).



* Example 1: Do ... ENDDO with TIMES

    out->write(  `----------------------------------` ).
    out->write(  `Example 1: DO ... ENDDO with TIMES` ).
    out->write(  `----------------------------------` ).

    DO c_number TIMES.
      out->write( `Hello World` ).
    ENDDO.


* Example 2: DO ... ENDDO with Abort Condition
**********************************************************************

    out->write(  `-------------------------------` ).
    out->write(  `Example 2: With Abort Condition` ).
    out->write(  `-------------------------------` ).

    number = c_number * c_number.

    " count backwards from number to c_number.
    DO.

      out->write( |{ sy-index }: Value of number: {  number }| ).
      number = number - 1.

      "abort condition
      IF number <= c_number.
        EXIT.
      ENDIF.

    ENDDO.

  ENDMETHOD.
ENDCLASS.
