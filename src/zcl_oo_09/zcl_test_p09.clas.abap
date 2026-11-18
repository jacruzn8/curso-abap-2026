CLASS zcl_test_p09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_P09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
   DATA(persona) = new zcl_persona_09(
                            iv_nombre = 'José Antnio'
                            iv_edad = 25 ).
   out->write( persona->saludar(  ) ).

   DATA(persona2) = new zcl_persona_09(
                            iv_nombre = 'Carlos'
                            iv_edad = 27 ).
   out->write( persona2->saludar(  ) ).

   data(alumno) = new zcl_alumno_09(
                                        iv_nombre = 'Sebastian'
                                        iv_edad = 24
                                        iv_curso = 'ABAP CLOUD'   ).
   out->write( alumno ).

   out->write( alumno->mostrar_curso( ) ).
   out->write( alumno->saludar(  ) ).

    data(alumno_redf) = new zcl_alumno_redf_09(
            iv_nombre = 'Blanca'
            iv_edad = 26
            iv_curso = 'Introducing Joule' ).

    out->write( alumno_redf ).

    out->write( alumno_redf->saludar(  ) ).


  ENDMETHOD.
ENDCLASS.
