CLASS zcl_09_path_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_PATH_EXPR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    SELECT
*    FROM /lrn/c_employee_ann
*    FIELDS employeeid,
*           firstname,
*           lastname,
*           departmentid
*    INTO TABLE @DATA(result).
*
*    out->write( result ).



    SELECT
      FROM Z09_C_EmployeeQuery
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
           departmentdescription,
           assistantname,
           \_department\_head-LastName as headname

    INTO TABLE @DATA(result).

    out->write( result ).



  ENDMETHOD.
ENDCLASS.
