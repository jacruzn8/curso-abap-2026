CLASS zcl_09_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES IF_OO_ADT_CLASSRUN.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_HELLO_WORLD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA(lv_username) = sy-uname.                   " Get the current username
  out->write( |Hello World, { lv_username }!| ).  " Output with username
ENDMETHOD.
ENDCLASS.
