CLASS z09_fill_employ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z09_FILL_EMPLOY IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_departments TYPE TABLE OF z09_depment.

    " 1. Borrar los registros existentes para evitar duplicados
    DELETE FROM z09_depment.

*    " 2. Definir los 5 registros de prueba
*    lt_departments = VALUE #(
*      ( client = '100' id = 'D01' description = 'Recursos Humanos' )
*      ( client = '100' id = 'D02' description = 'Finanzas y Contabilidad' )
*      ( client = '100' id = 'D03' description = 'Tecnologias de la Informacion' )
*      ( client = '100' id = 'D04' description = 'Ventas y Marketing' )
*      ( client = '100' id = 'D05' description = 'Logistica y Operaciones' )
*    ).
*
*    " 3. Insertar los nuevos datos en la tabla
*    INSERT z09_depment FROM TABLE @lt_departments.
*
*    " 4. Mostrar el resultado en la consola ABAP
*    out->write( |Se han insertado { sy-dbcnt } registros correctamente.| ).
*    out->write( '¡Hecho!' ).

  ENDMETHOD.
ENDCLASS.
