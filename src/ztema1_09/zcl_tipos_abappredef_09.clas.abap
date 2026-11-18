CLASS zcl_tipos_abappredef_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TIPOS_ABAPPREDEF_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*  DATA variable TYPE string.
* DATA variable TYPE i.
*  data variable TYPE d.
  data variABLE TYPE C LENGTH 10.
*  DATA VARIABLE TYPE N LENGTH 10.
*   DATA VARIABLE TYPE P LENGTH 8 DECIMALS 2.

*  oUTPUT
*********************************************************
vARIABLE = '193399'.
OUT->WRITE(  ' RESULT OF INITIAL VARIABLE  type i' ).
OUT->WRITE( VARIABLE ).
OUT->WRITE( '--------------------' ).


vARIABLE = '19999'.

OUT->WRITE(  ' RESULT OF INITIAL VARIABLE ' ).
OUT->WRITE( VARIABLE ).
OUT->WRITE( '--------------------' ).

  ENDMETHOD.
ENDCLASS.
