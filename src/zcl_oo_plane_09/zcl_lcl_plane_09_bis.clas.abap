CLASS zcl_lcl_plane_09_bis   DEFINITION
PUBLIC

Create public.

PUBLIC SECTION.
TYPES: BEGIN OF ts_attributes,
name TYPE string,
value TYPE string,
END OF ts_attributes,
* declare table - do not allow the same attribute to be used more than once
tt_attributes TYPE SORTED TABLE OF ts_attributes WITH UNIQUE KEY name.


METHODS constructor IMPORTING iv_manufacturer TYPE string
iv_type TYPE string.
METHODS: get_Attributes RETURNING VALUE(rt_Attributes) TYPE tt_attributes.


PROTECTED SECTION.
DATA manufacturer TYPE string.
DATA type TYPE string.

PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_LCL_PLANE_09_BIS IMPLEMENTATION.


METHOD constructor.
manufacturer = iv_manufacturer.
type = iv_type.
ENDMETHOD.


METHOD get_attributes.
rt_attributes = VALUE #( ( name = 'MANUFACTURER' value = manufacturer )
( name = 'TYPE' value = type ) ) .
ENDMETHOD.
ENDCLASS.
