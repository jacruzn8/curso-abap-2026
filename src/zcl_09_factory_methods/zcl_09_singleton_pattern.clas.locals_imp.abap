*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection definition create private.
PUBLIC section.
    methods constructor
        importing
            airlineid           TYPE /dmo/carrier_id
            connectionnumber    TYPE /dmo/connection_id
            fromAirport         TYPE /dmo/airport_from_id
            toAirport           TYPE /dmo/airport_to_id.

CLASS-methods get_connection importing
    airlineID        TYPE /dmo/carrier_id
    connectionNumber TYPE /dmo/connection_id
RETURNING value(ro_connection) TYPE REF to lcl_connection.

PRIVATE section.


    types:
          BEGIN OF ts_instance,
          airlineId TYPE /dmo/carrier_id,
          connectionNumber TYPE /dmo/connection_id,
          object TYPE REF to lcl_connection,
          END of ts_instance,

          tt_instances type HASHED TABLE of ts_instance
          with unique key airlineID connectionNumber.

          DATA airlineID        TYPE /dmo/carrier_id.
          DATA connectionNumber TYPE /dmo/connection_id.
          DATA fromAirport      type /dmo/airport_from_id.
          DATA toAirport        TYPE /dmo/airport_to_id.

          CLASS-DATA connections TYPE tt_instances.
          ENDCLASS.


class lcl_connection implementation.

    method constructor.
        me->airlineid = airlineid.
        me->connectionnumber = connectionnumber.
        me->fromairport =  fromairport.
        me->toairport = toairport.

    endmethod.


    method get_connection.

        data fromAirport type /dmo/airport_from_id.
        DATA toAirport   TYPE /dmo/airport_to_id.


        if not line_exists(  connections[ airlineid = airlineID connectionnumber = connectionnumber  ] ).
            select single from /dmo/connection fields airport_from_id, airport_to_id
            where carrier_id = @airlineid
            and connection_id = @connectionnumber
            into (  @fromAirport, @toAirport ).

            ro_connection = new #( airlineid = airlineid connectionnumber = connectionnumber fromairport = fromairport toairport = toairport   ).
            data(new_instance) = VALUE ts_instance( airlineID = airlineID connectionnumber = connectionnumber object = ro_connection ).
            insert new_instance into table connections.
        else.
            ro_connection = connections[  AirlineID = airlineid connectionnumber = connectionnumber ]-object.
        endif.


    ENDMETHOD.

ENDCLASS.



