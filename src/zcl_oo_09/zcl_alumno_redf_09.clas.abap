CLASS zcl_alumno_redf_09 DEFINITION
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

     METHODS saludar REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA curso TYPE string.

ENDCLASS.



CLASS ZCL_ALUMNO_REDF_09 IMPLEMENTATION.


  method mostrar_curso.

    rv_mensaje = | Estoy estudiando  { me->curso } |.

    RETURN rv_mensaje.

  ENDMETHOD.


  METHOD constructor.

    super->constructor( iv_nombre = iv_nombre iv_edad = iv_edad ).

    me->curso = iv_curso.

  ENDMETHOD.


  METHOD saludar.
    rv_mensaje = super->saludar(  ) && | Soy Alumno. Estudio { me->curso }  y voy a certificarme. | .


  ENDMETHOD.
ENDCLASS.
