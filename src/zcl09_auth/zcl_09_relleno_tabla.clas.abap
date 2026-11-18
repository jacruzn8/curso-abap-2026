CLASS zcl_09_relleno_tabla DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_RELLENO_TABLA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA lt_carriers TYPE STANDARD TABLE OF /dmo/carrier.
    DATA ls_carrier  TYPE /dmo/carrier.

    " Definimos los datos de prueba para LH y UA
    " Nota: Ajusta los campos según la estructura real de /DMO/CARRIER (Client, Carrier ID, Name, Currency Code)

    ls_carrier-carrier_id   = 'LH'.
    ls_carrier-name         = 'Lufthansa'.
    ls_carrier-currency_code = 'EUR'.
    APPEND ls_carrier TO lt_carriers.

    ls_carrier-carrier_id   = 'UA'.
    ls_carrier-name         = 'United Airlines'.
    ls_carrier-currency_code = 'USD'.
    APPEND ls_carrier TO lt_carriers. " Ojo: APPEND ls_carrier TO lt_carriers

    " Insertamos o modificamos los registros en la tabla
    MODIFY /dmo/carrier FROM TABLE @lt_carriers.

    IF sy-subrc = 0.
      out->write( '¡Datos de prueba generados con éxito en /DMO/CARRIER!' ).
    ELSE.
      out->write( 'Aviso: Hubo algún problema al insertar los datos.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
