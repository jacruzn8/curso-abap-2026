class zcl_lcl_passenger_plane_09_bis

Definition PUBLIC

inheriting from zcl_lcl_plane_09_bis.

PUBLIC SECTION.

methods constructor importing iv_manufacturer TYPE string
    iv_type TYPE string
    iv_seats TYPE i.

methods get_attributes REDEFINITION.

private section.
DATA seats TYPE i.

ENDCLASS.



CLASS ZCL_LCL_PASSENGER_PLANE_09_BIS IMPLEMENTATION.


method constructor.

super->constructor( iv_manufacturer = iv_manufacturer
                iv_type = iv_type ).

ENDMETHOD.


method get_attributes.
* redefinition uses call of superclass implementation

rt_attributes = super->get_attributes( ).
rt_attributes = value #( base rt_attributes ( name = 'SEATS' value = seats ) ).

endmethod.
ENDCLASS.
