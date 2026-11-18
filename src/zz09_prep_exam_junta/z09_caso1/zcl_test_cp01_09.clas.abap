CLASS zcl_test_cp01_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_cp01_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  " 1. Definición de la estructura de vuelos y tipo de tabla estándar con clave vacía
    TYPES: BEGIN OF ty_flight,
             airline    TYPE c LENGTH 3,
             flight_num TYPE n LENGTH 4,
             origin     TYPE c LENGTH 3,
             dest       TYPE c LENGTH 3,
             price      TYPE p LENGTH 8 DECIMALS 2,
             seats_free TYPE i,
           END OF ty_flight,
           tt_flights TYPE STANDARD TABLE OF ty_flight WITH EMPTY KEY.

    " 2. Rellenar la tabla interna de prueba (lt_flights) con al menos 8 registros variados
    DATA(lt_flights) = VALUE tt_flights(
      ( airline = 'LH' flight_num = '0400' origin = 'FRA' dest = 'JFK' price = '850.50' seats_free = 12 )
      ( airline = 'IB' flight_num = '3400' origin = 'MAD' dest = 'BCN' price = '120.00' seats_free = 45 )
      ( airline = 'UA' flight_num = '0057' origin = 'JFK' dest = 'SFO' price = '430.20' seats_free = 8  )
      ( airline = 'AA' flight_num = '0100' origin = 'MIA' dest = 'JFK' price = '290.00' seats_free = 30 )
      ( airline = 'BA' flight_num = '0484' origin = 'LHR' dest = 'MAD' price = '210.00' seats_free = 14 )
      ( airline = 'AF' flight_num = '1180' origin = 'CDG' dest = 'BCN' price = '180.50' seats_free = 22 )
      ( airline = 'EK' flight_num = '0202' origin = 'DXB' dest = 'JFK' price = '950.00' seats_free = 5  )
      ( airline = 'LA' flight_num = '0500' origin = 'SCL' dest = 'MAD' price = '780.00' seats_free = 19 )
    ).

    " 3. Mostrar los resultados en la consola ABAP
    out->write( |Se han cargado { lines( lt_flights ) } registros de vuelos correctamente.| ).
    out->write( data = lt_flights ).

    " =========================================================================
    " TAREA 1.1: Clasificación de Precios con Expresiones Condicionales (COND)
    " =========================================================================
    out->write( '--- TAREA 1.1: CLASIFICACIÓN DE PRECIOS ---' ).

    LOOP AT lt_flights INTO DATA(ls_flight).

      DATA(lv_category) = COND string(
        WHEN ls_flight-price < 150   THEN 'Económico'
        WHEN ls_flight-price <= 500  THEN 'Estándar'
        WHEN ls_flight-price <= 1000 THEN 'Premium'
        ELSE 'First Class'
      ).

      out->write( |Vuelo: { ls_flight-airline }-{ ls_flight-flight_num } | &&
                  |({ ls_flight-origin } -> { ls_flight-dest }) \| | &&
                  |Precio: { ls_flight-price } EUR \| | &&
                  |Categoría: { lv_category }| ).

    ENDLOOP.

    " =========================================================================
    " TAREA 1.2: Filtrado Avanzado con Operadores lógicos (VALUE y FOR)
    " =========================================================================
    out->write( ' ' ).
    out->write( '--- TAREA 1.2: VUELOS FILTRADOS (FRA, PLAZAS > 0, PRECIO <= 1000) ---' ).

    DATA(lt_filtered) = VALUE tt_flights(
      FOR ls_f IN lt_flights
      WHERE ( seats_free > 0
              AND ( origin = 'FRA' OR dest = 'FRA' )
              AND price <= 1000 )
      ( ls_f )
    ).

    out->write( data = lt_filtered ).

    " =========================================================================
    " TAREA 1.3: Transformación y Manipulación de Cadenas
    " =========================================================================
    out->write( ' ' ).
    out->write( '--- TAREA 1.3: TRANSFORMACIÓN Y MANIPULACIÓN DE CADENAS ---' ).

    LOOP AT lt_filtered INTO DATA(ls_filt).

      " 1. Concatenar aerolínea y número de vuelo usando templates de string
      DATA(lv_flight_code) = |{ ls_filt-airline }{ ls_filt-flight_num }|.

      " 2. Convertir el código de destino a minúsculas
      DATA(lv_dest_lower) = to_lower( ls_filt-dest ).

      " 3. Calcular la longitud del código concatenado
      DATA(lv_code_len) = strlen( lv_flight_code ).

      " 4. Mostrar el resultado formateado por consola
      out->write( |Código Vuelo: { lv_flight_code } (Longitud: { lv_code_len }) \| Destino (minúsculas): { lv_dest_lower }| ).

    ENDLOOP.


    " =========================================================================
    " TAREA 1.4: Cálculos Agregados con Funciones Numéricas y REDUCE
    " =========================================================================
    out->write( ' ' ).
    out->write( '--- TAREA 1.4: CÁLCULOS AGREGADOS CON REDUCE ---' ).

    TYPES: BEGIN OF ty_price_stats,
             max_price   TYPE p LENGTH 8 DECIMALS 2,
             min_price   TYPE p LENGTH 8 DECIMALS 2,
             total_price TYPE p LENGTH 10 DECIMALS 2,
           END OF ty_price_stats.

    " 1. Precio máximo, mínimo (inicializado con el primer registro) y suma total en un solo recorrido
    DATA(ls_price_stats) = REDUCE ty_price_stats(
      INIT stats = VALUE ty_price_stats(
        max_price   = 0
        min_price   = COND #( WHEN lt_flights IS NOT INITIAL THEN lt_flights[ 1 ]-price ELSE 0 )
        total_price = 0
      )
      FOR ls_fl IN lt_flights
      NEXT stats-max_price   = nmax( val1 = stats-max_price val2 = ls_fl-price )
           stats-min_price   = nmin( val1 = stats-min_price val2 = ls_fl-price )
           stats-total_price = stats-total_price + ls_fl-price
    ).

    " 2. Número total de registros y precio medio redondeado a 2 decimales con round()
    DATA(lv_total_flights) = lines( lt_flights ).
    DATA(lv_avg_price)     = COND decfloat34(
      WHEN lv_total_flights > 0
      THEN round( val = ls_price_stats-total_price / lv_total_flights dec = 2 )
      ELSE 0
    ).

    " 3. Total de plazas libres acumuladas mediante otro bloque REDUCE
    DATA(lv_total_seats) = REDUCE i(
      INIT seats = 0
      FOR ls_fl IN lt_flights
      NEXT seats = seats + ls_fl-seats_free
    ).

    " 4. Imprimir métricas obtenidas
    out->write( |Precio Máximo: { ls_price_stats-max_price } EUR| ).
    out->write( |Precio Mínimo: { ls_price_stats-min_price } EUR| ).
    out->write( |Precio Medio: { lv_avg_price } EUR (sobre { lv_total_flights } vuelos)| ).
    out->write( |Plazas Libres Totales: { lv_total_seats }| ).


  ENDMETHOD.
ENDCLASS.
