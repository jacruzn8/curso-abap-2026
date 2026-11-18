CLASS z_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

DATA(avion1) = new zcl_lcl_plane_09_bis( iv_manufacturer = 'AIRBUS'  iv_type = 'LIGHT'                ).
out->write( avion1->get_attributes( ) ).
out->write( |""""""""""""""""""""""""""""""""""""""""""""""| ).



data(Avion_cargo) = new zcl_lcl_cargo_plane_09_bis( iv_cargo = 200 iv_manufacturer = 'AIRBUS' iv_type = '3' ).
out->write( avion_cargo->get_attributes( ) ).
out->write( |""""""""""""""""""""""""""""""""""""""""""""""| ).


data(avion_pasajeros) = new zcl_lcl_passenger_plane_09_bis( iv_manufacturer = 'AIRBUS' iv_seats = 400  iv_type = '5' ).
out->write( avion_pasajeros->get_attributes( ) ).
out->write( |""""""""""""""""""""""""""""""""""""""""""""""| ).




  ENDMETHOD.
ENDCLASS.
