CLASS zcl_p00_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_P00_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(persona) = NEW lcl_persona(
                            iv_nombre = 'Pedro'
                            iv_edad = '45' ).

    out->write( persona ).
    out->write( persona->saludar( ) ).

  ENDMETHOD.
ENDCLASS.
