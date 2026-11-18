CLASS zcl_alumno_09 DEFINITION
  PUBLIC
  INHERITING FROM zcl_persona_09

  CREATE PUBLIC .

  PUBLIC SECTION.
    methods constructor
    importing
        iv_nombre   type string
        iv_edad     TYPE i
        iv_curso    TYPE string.
     methods mostrar_curso RETURNING VALUE(rv_mensaje) type string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA curso TYPE string.

ENDCLASS.



CLASS ZCL_ALUMNO_09 IMPLEMENTATION.


  method mostrar_curso.

    rv_mensaje = | Estoy estudiando  { me->curso } |.

    RETURN rv_mensaje.

  ENDMETHOD.


  METHOD constructor.

    super->constructor( iv_nombre = iv_nombre iv_edad = iv_edad ).

    me->curso = iv_curso.

  ENDMETHOD.
ENDCLASS.
