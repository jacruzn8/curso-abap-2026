class zcl_lcl_cargo_plane_09_bis

Definition PUBLIC
INHERITING FROM ZCL_lcl_plane_09_BIS

CREATE PUBLIC.
public section.
methods constructor importing iv_manufacturer type string
    iv_type     TYPE string
    iv_cargo    TYPE i.

methods get_attributes REDEFINITION.

private section.
    DATA cargo TYPE i.

ENDCLASS.



CLASS ZCL_LCL_CARGO_PLANE_09_BIS IMPLEMENTATION.


method constructor.

   super->constructor( iv_manufacturer = iv_manufacturer
                        iv_type         = iv_type ).

    cargo = iv_cargo.


ENDMethod.


Method get_attributes.
* Method uses protected attributes for superclass

rt_attributes = value #( ( name = 'MANUFACTURER' value = manufacturer )
                        ( name = 'TYPE' value = type )
                        ( name = 'CARGO' value = cargo ) ).

ENDMETHOD.
ENDCLASS.
