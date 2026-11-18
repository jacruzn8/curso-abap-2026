CLASS z09_fill DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z09_FILL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

     DATA lt_employees TYPE TABLE OF z09_employ.
    DATA ls_employee  TYPE z09_employ.

    " 1. Opcional: Limpiar la tabla antes de insertar para evitar duplicados en pruebas
    DELETE FROM z09_employ.

    " 2. Preparar los datos de prueba (Primer registro)
    ls_employee-client        = sy-mandt.
    ls_employee-employee_id   = '01'.
    ls_employee-first_name    = 'María'.
    ls_employee-last_name     = 'Ledesma'.
    ls_employee-birth_date    = '19900515'.
    ls_employee-entry_date    = '20230101'.
    ls_employee-annual_salary = '45000.00'.
    ls_employee-currency_code = 'EUR'.

    " Datos administrativos (incluidos en la estructura include zsadmin_00)
    " Dependiendo de cómo esté definido tu include, normalmente incluye created_by, created_at, etc.
    ls_employee-created_by    = sy-uname.


    APPEND ls_employee TO lt_employees.

    " Preparar los datos de prueba (Segundo registro)
    ls_employee-client        = sy-mandt.
    ls_employee-employee_id   = '02'.
    ls_employee-first_name    = 'Carlos'.
    ls_employee-last_name     = 'García'.
    ls_employee-birth_date    = '19851020'.
    ls_employee-entry_date    = '20220615'.
    ls_employee-annual_salary = '52000.00'.
    ls_employee-currency_code = 'EUR'.
    ls_employee-created_by    = sy-uname.

    APPEND ls_employee TO lt_employees.

    " 3. Insertar masivamente los registros en la tabla de base de datos
    INSERT z09_employ FROM TABLE @lt_employees.

    " 4. Verificar el resultado en la consola de Eclipse
    IF sy-subrc = 0.
      out->write( |¡Éxito! Se han insertado { lines( lt_employees ) } empleados en la tabla Z09_EMPLOY.| ).
    ELSE.
      out->write( |Error: No se pudieron insertar los registros.| ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
