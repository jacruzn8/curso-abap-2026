CLASS zcl_persona_09 DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.
     DATA nombre TYPE string.
    DATA edad TYPE i.

     methods constructor
            importing
                iv_nombre TYPE string
                iv_edad TYPE i.

     methods saludar
            RETURNING VALUE(rv_mensaje) type string.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_PERSONA_09 IMPLEMENTATION.


METHOD constructor.
    me->nombre = iv_nombre.
    me->edad   = iv_edad.

ENDMETHOD.


method saludar.
    rv_mensaje = | Hola, soy { me->nombre }  y tengo  { me->edad }  años |.


endmethod.
ENDCLASS.
