CLASS zcl_test_cp02_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
        Types: BEGIN OF ty_reserva,
               id_reserva   TYPE i,
               airline      TYPE c LENGTH 2,
               num_vuelo    TYPE n LENGTH 4,
               pasajero     TYPE string,
               fecha        TYPE d,
               precio       TYPE p length 8 decimals 2,
               estado       type c length 1,
           END of ty_reserva.

        types: tt_reservas type standard table of ty_reserva
            with non-unique key id_reserva.
        TYPES ty_precio TYPE p length 8 decimals 2.

ENDCLASS.



CLASS zcl_test_cp02_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


* Carga de datos iniciales
* ------------------------------------------------------------------------------------
DATA(lt_res) = VALUE tt_reservas(
    ( id_reserva = 1 airline = 'LH' num_vuelo = '0400'
      pasajero = |Ana Garcia|      fecha = '20260515'
      precio = '899.00' estado = 'A' )
    ( id_reserva = 2 airline = 'IB' num_vuelo = '3740'
      pasajero = |Carlos Lopez|   fecha = '20260515'
      precio = '120.00' estado = 'A' )
    ( id_reserva = 3 airline = 'AA' num_vuelo = '0017'
      pasajero = |John Smith|     fecha = '20260520'
      precio = '450.50' estado = 'A' )
    ( id_reserva = 4 airline = 'LH' num_vuelo = '0455'
      pasajero = |Maria Perez|    fecha = '20260520'
      precio = '310.75' estado = 'A' )
    ( id_reserva = 5 airline = 'IB' num_vuelo = '3740'
      pasajero = |Pedro Ruiz|     fecha = '20260515'
      precio = '120.00' estado = 'C' )
    ( id_reserva = 6 airline = 'SQ' num_vuelo = '0026'
      pasajero = |Lisa Tan|       fecha = '20260601'
      precio = '1250.00' estado = 'A' )
    ( id_reserva = 7 airline = 'LH' num_vuelo = '0400'
      pasajero = |Hans Muller|    fecha = '20260515'
      precio = '899.00' estado = 'A' )
    ( id_reserva = 8 airline = 'AA' num_vuelo = '0064'
      pasajero = |Sarah Jones|    fecha = '20260525'
      precio = '510.00' estado = 'A' )
).

 " =========================================================================
 " TAREA 2.1: Altas e Inserciones en Memoria
 " =========================================================================
    out->write( '--- TAREA 2.1: ALTAS E INSERCIONES EN MEMORIA ---' ).

" Añadir dos nuevas reservas utilizando la sintaxis APPEND VALUE #( ... )
    APPEND VALUE #( id_reserva = 6 pasajero = 'Lisa Tan'    airline = 'LH' num_vuelo = '2030' precio = '180.00' estado = 'A' ) TO lt_res.
    APPEND VALUE #( id_reserva = 7 pasajero = 'David Smith' airline = 'SQ' num_vuelo = '0026' precio = '950.00' estado = 'A' ) TO lt_res.

    out->write( |Se han añadido 2 nuevas reservas (6 y 7). Total registros: { lines( lt_res ) }| ).
    out->write( data = lt_res ).

" Tarea 2.2: Modificaciones Puntuales y Procesamiento Masivo
" 1. Modificación puntual del precio de la reserva 3 a 480.00 EUR
    READ TABLE lt_res WITH KEY id_reserva = 3 ASSIGNING FIELD-SYMBOL(<fs_res3>).
    IF sy-subrc = 0.
      <fs_res3>-precio = '480.00'.
    ENDIF.
    out->write( |Ejercicio 2.2 Modificar precio a 480, para reserva 3| ).
    out->write( data = lt_res ).


" 2. Descuento masivo del 10% en reservas de la aerolínea 'LH'
    LOOP AT lt_res ASSIGNING FIELD-SYMBOL(<fs_lh>) WHERE airline = 'LH'.
      <fs_lh>-precio = <fs_lh>-precio * '0.90'.
    ENDLOOP.

    out->write( |Ejercicio 2.2 Descuento aplicado sobre el precio para aerolínea 'LH'| ).
    out->write( data = lt_res ).


** Tarea 2.3 Gestión de Cancelaciones y Purga de Registros
 " 1. Cambiar el estado de la reserva 4 a 'C' (Cancelada)
    READ TABLE lt_res WITH KEY id_reserva = 4 ASSIGNING FIELD-SYMBOL(<fs_res4>).
    IF sy-subrc = 0.
      <fs_res4>-estado = 'C'.
    ENDIF.

    out->write( |Ejercicio 2.3 Parte 1, cancelar reserva con ID = 4.| ).
    out->write( data = lt_res ).

    " 2. Purga masiva de registros cancelados
    DATA(lv_before_delete) = lines( lt_res ).

    DELETE lt_res WHERE estado = 'C'.

    DATA(lv_after_delete) = lines( lt_res ).
    DATA(lv_deleted_count) = lv_before_delete - lv_after_delete.

    out->write( |Registros eliminados (Estado C): { lv_deleted_count }| ).
    out->write( |Registros restantes en lt_res: { lv_after_delete }| ).
    out->write( data = lt_res ).


* Tarea 2.4: Métodos Avanzados de Búsqueda y Lectura en Memoria
* Instrucción:
*1. Comprobación de existencia: Verifica si la pasajera 'Lisa Tan'; existe
*   en la tabla sin copiar datos a memoria utilizando READ TABLE ... TRANSPORTING NO FIELDS.
   READ TABLE lt_res WITH KEY pasajero = 'Lisa Tan' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      out->write( 'La pasajera Lisa Tan existe en la tabla de reservas.' ).
    ELSE.
      out->write( 'La pasajera Lisa Tan no fue encontrada.' ).
    ENDIF.

*2. Obtención por referencia: Recupera un puntero de lectura al registro
*   con id_reserva = 6 mediante READ TABLE ... REFERENCE INTO.

    READ TABLE lt_res WITH KEY id_reserva = 6 REFERENCE INTO DATA(lr_res6).
    IF sy-subrc = 0.
      out->write( |Reserva recuperada por referencia: ID { lr_res6->id_reserva }, Pasajero { lr_res6->pasajero }| ).
    ENDIF.


*3. Expresión de tabla: Recupera de forma directa el nombre del pasajero
*   de la reserva id_reserva = 1 utilizando la sintaxis lt_res[
*   id_reserva = 1 ]-pasajero, capturando la posible excepción
*   cx_sy_itab_line_not_found dentro de un bloque TRY/CATCH.

 TRY.
        DATA(lv_pasajero_id1) = lt_res[ id_reserva = 1 ]-pasajero.
        out->write( |Pasajero obtenido por expresión de tabla (ID 1): { lv_pasajero_id1 }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( 'La reserva con ID 1 no existe.' ).
    ENDTRY.
**********************************************************************
* Busqueda pasajero que no existe para forzar el disparo de la excepción
TRY.
        DATA(lv_pasajero_id2) = lt_res[ id_reserva = 10 ]-pasajero.
        out->write( |Pasajero obtenido por expresión de tabla (ID 10): { lv_pasajero_id2 }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( 'La reserva con ID 10 no existe.' ).
    ENDTRY.

**********************************************************************
* Tarea 2.5: Agrupación, Conteo y Métricas Analíticas por Aerolínea
* Requisito: Generar un informe resumido del volumen de ventas agrupado por aerolínea.

* Buscamos las reservas activas
   DATA(lt_activas) = VALUE tt_reservas(
      FOR ls_r IN lt_res
      WHERE ( estado = 'A' )
      ( ls_r )
    ).

" Realizamos las agrupaciones
LOOP AT lt_activas INTO DATA(ls_activa)
GROUP BY ( airline = ls_activa-airline )
INTO DATA(group_airline).

      " Obtener el número de reservas dentro del grupo
      DATA(lv_count) = REDUCE i( INIT cnt = 0
                               FOR ls_grp IN GROUP group_airline
                               NEXT cnt += 1 ).

     " Sumar los precios de las reservas del grupo con REDUCE
   " Sumar los precios de las reservas del grupo con REDUCE
    DATA(lv_total_sales) = REDUCE decfloat34(
        INIT sum = CONV decfloat34( 0 )
        FOR ls_grp IN GROUP group_airline
        NEXT sum = sum + ls_grp-precio
    ).

      " Calcular el precio medio redondeado a 2 decimales
      DATA(lv_avg_price) = COND decfloat34(
        WHEN lv_count > 0
        THEN round( val = lv_total_sales / lv_count dec = 2 )
        ELSE 0
      ).

      out->write( |Aerolínea: { group_airline-airline } \| | &&
                  |Cantidad Reservas: { lv_count } \| | &&
                  |Total Ventas: { lv_total_sales } EUR \| | &&
                  |Precio Medio: { lv_avg_price } EUR| ).

    ENDLOOP.



  ENDMETHOD.
ENDCLASS.
