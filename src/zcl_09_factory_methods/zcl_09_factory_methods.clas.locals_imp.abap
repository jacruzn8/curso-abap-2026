CLASS lcl_connection DEFINITION create PRIVATE.

   public section.
   methods constructor
      importing airlineid TYPE /dmo/carrier_id
      connectionnumber TYPE /dmo/connection_id
      fromAirport   TYPE /DMO/AIRPORT_from_id
      toAirport     TYPE /dmo/airport_to_id.


  CLASS-methods get_connection importing airlineId TYPE /DMO/carrier_id
  connectionNumber TYPE /DMO/Connection_id
  RETURNING VALUe(ro_connection) TYPE REF to lcl_connection.

  PRIVATE section.
    DATA AirlineID  TYPE /dmo/carrier_id.
    data connectionNumber   type /dmo/connection_id.
    DATA fromAirport    TYPE /dmo/airport_from_id.
    DATA toAirport      TYPE /dmo/airport_to_id.
ENDCLASS.


class lcl_connection implementation.

Method Constructor.
    me->airlineid = airlineid.
    me->connectionnumber = connectionnumber.
    me->fromAirport = fromAirport.
    me->toAirport = toAirport.

ENDMETHOD.

Method get_connection.

    DATA fromAirport type /dmo/airport_from_id.
    DATA toAirport   TYPE /dmo/airport_to_id.

    select single from /dmo/connection fields airport_from_id, airport_to_id
        where carrier_id = @airlineid
        and connection_id = @connectionnumber
        into (  @fromAirport, @toAirport ).


    ro_connection = new #(  airlineid = airlineid connectionnumber = connectionnumber fromairport = fromairport toairport = toairport ).


    ENDMETHOD.

ENDCLASS.

