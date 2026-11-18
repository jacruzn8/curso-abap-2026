*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_persona definition.

    public section.
        DATA nombre type string.
        data edad type i.

        methods constructor
            importing
                iv_nombre TYPE string
                iv_edad TYPE i.

        methods saludar
            RETURNING VALUE(rv_mensaje) type string.

    PROTECTED SECTION.
    PRIVATE SECTION.

ENDCLASS.

class lcl_persona IMPLEMENTATION.

METHOD constructor.
    me->nombre = iv_nombre.
    me->edad   = iv_edad.
ENDMETHOD.


method saludar.
    rv_mensaje = | Hola, soy { me->nombre }  y tengo  { me->edad }  años |.
endmethod.

ENDCLASS.

