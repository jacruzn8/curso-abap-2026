CLASS zcl_09_fill_table_courses DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

" Definición del tipo de tabla estándar basado en la tabla de BD
    TYPES tt_courses TYPE STANDARD TABLE OF z09_traininglist WITH EMPTY KEY.

    " Definición del método con RETURNING tipado como tabla
    METHODS get_available_courses
      IMPORTING
        !i_country_code  TYPE ztraining_country_code
      RETURNING
        VALUE(r_courses) TYPE tt_courses.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_09_fill_table_courses IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



    DATA: lt_courses TYPE TABLE  of Z09_traininglist.

    " 1. Definir los registros de prueba basados en la tabla
    lt_courses = VALUE #(
      ( client = sy-mandt course_id = 'C001' title = 'ABAP Basics'     modality = 'PRESENCIAL' country_code = 'ES' )
      ( client = sy-mandt course_id = 'C002' title = 'ABAP Cloud'      modality = 'ONLINE'     country_code = '--' )
      ( client = sy-mandt course_id = 'C003' title = 'SAP BTP'         modality = 'PRESENCIAL' COUntry_code = 'DE' )
      ( client = sy-mandt course_id = 'C004' title = 'CDS Views'       modality = 'ONLINE'     country_code = '--' )
      ( client = sy-mandt course_id = 'C005' title = 'RAP Development' modality = 'PRESENCIAL' country_code = 'ES' )
    ).

    " 2. Limpiar la tabla previa para evitar errores de clave duplicada
    DELETE FROM z09_TRAININGLIST. " Reemplaza ### con tus iniciales o número

    " 3. Insertar los datos en la tabla de base de datos
    INSERT z09_TRAININGLIST FROM TABLE @lt_courses.

    " 4. Mostrar el resultado por consola
    IF sy-subrc = 0.
      out->write( |Se han insertado { sy-dbcnt } registros correctamente en la tabla.| ).
      out->write( lt_courses ).
    ELSE.
      out->write( 'Error al insertar los datos en la tabla.' ).
    ENDIF.

    DATA(lo_catalog) = NEW zcl_09_fill_table_courses( ).
    DATA(lv_test_country) = CONV ztraining_country_code( 'ES' ).

    out->write( |=== PROBANDO CATÁLOGO DE CURSOS PARA EL PAÍS: { lv_test_country } ===| ).

   " Invocación del método de la clase asignando a una tabla interna
    DATA lt_courses_result TYPE TABLE OF z09_traininglist.

    lt_courses_result =  lo_catalog->get_available_courses( i_country_code = lv_test_country ) .

    " Salida de resultados por consola
    out->write( |Se han encontrado { lines( lt_courses_result ) } cursos disponibles.| ).
    out->write( data = lt_courses_result ).



  ENDMETHOD.

 METHOD get_available_courses.
    " Limpieza inicial de la tabla de retorno
    CLEAR r_courses.

    " Validar que el parámetro de entrada no esté vacío
    IF i_country_code IS INITIAL.
      RETURN.
    ENDIF.

    " Selección de los cursos del país indicado o que sean ONLINE
    SELECT course_id,
           title,
           modality,
           country_code
      FROM z09_traininglist
      WHERE country_code = @i_country_code
         OR modality     = 'ONLINE'
      INTO TABLE @r_courses.
  ENDMETHOD.

ENDCLASS.
