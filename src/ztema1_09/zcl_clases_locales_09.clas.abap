CLASS zcl_clases_locales_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    METHODS constructor
    importing
    i_carrier_id  TYPE /DMO/CARRIER_id
    i_connection_id TYPE /DMO/carrier_id
    .
    DATA counter TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

  DATA carrier_id type /DMO/CARRIER_id.
  DATA connection_id TYPE /DMO/carrier_id.

ENDCLASS.



CLASS ZCL_CLASES_LOCALES_09 IMPLEMENTATION.


  METHOD constructor.

  super->constructor( ).

me->counter = 0.
me->carrier_id = i_carrier_id.
me->connection_id = i_connection_id.

Counter = counter + 1.


  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

  DATA connection type REF to lcl_connection.
  data connections TYPE TABLE of REF TO lcl_connection.

  connection = new #(   ).
  connection->carrier_id = 'LH'.
  connection->connection_id = '0400'.

  APPEND connection to connections.

  connection = new #(   ).
  connection->carrier_id = 'BA'.
  connection->connection_id = '0064'.

  APPEND connection to connections.

  connection = new #(   ).
  connection->carrier_id = 'AA'.
  connection->connection_id = '0017'.

  APPEND connection to connections.

  connection = new #(   ).
  connection->carrier_id = 'SQ'.
  connection->connection_id = '0001'.

  APPEND connection to connections.


  out->write( connections ).



  ENDMETHOD.
ENDCLASS.
