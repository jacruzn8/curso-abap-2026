CLASS zcl_select_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SELECT_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA airport_from_id TYPE /DMO/airport_from_id.
    DATA airport_to_id   TYPE /DMO/airport_to_id.
    DATA: i_carrier_id TYPE /dmo/carrier_id,
          I_CONNECTION_ID TYPE /dmo/connection_id,
          CARRIER_NAME TYPE /dmo/carrier_name.

* Example 1
************************
    SELECT SINGLE
     FROM /dmo/connection
     FIELDS airport_from_id
     WHERE carrier_id = 'LH'
       AND connection_id = '0400'
       INTO @airport_from_id.

    out->write( airport_from_id ).

* Example 2
************************
    SELECT SINGLE
     FROM /dmo/connection
     FIELDS airport_from_id, airport_to_id
     WHERE carrier_id = 'LH'
       AND connection_id = '0400'
       INTO (@airport_from_id , @airport_to_id).

    out->write(  'Example 2' ).
    out->write( airport_to_id ).

    out->write( |Flight LH 400 departs from {  airport_from_id } and arrives to { airport_to_id }.| ).


* Example 3: Empty Result and sy-subrc
**********************************************************************
    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id
      WHERE carrier_id    = 'XX'
        AND connection_id = '1234'
        INTO @airport_from_id.

SELECT SINGLE
      FROM /dmo/i_connection
      FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
      WHERE airlineid    = @i_carrier_id
        AND connectionid = @i_connection_id
        INTO ( @airport_from_id, @airport_to_id, @carrier_name ).

    IF sy-subrc = 0.

      out->write( `----------`  ).
      out->write( `Example 3:`  ).
      out->write( |Flight XX 1234 departs from {  airport_from_id }.| ).

    ELSE.

      out->write( `----------`  ).
      out->write( `Example 3:`  ).
      out->write( |There is no flight XX 1234, but still airport_from_id = {  airport_from_id }!| ).

    ENDIF.


  ENDMETHOD.
ENDCLASS.
