CLASS zcl_09_parameter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_PARAMETER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT
*    FROM /LRN/C_Employee_Ann
*     FROM /lrn/c_employee_qry
    from Z09_C_EmployeeQuery3(
        p_target_curr = 'JPY'
*        ,
*        p_date        = @sy-datum
)
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
                  departmentdescription,
           assistantname,
           \_department\_head-lastname AS headname,

           MonthlySalaryConverted,
           CurrencyCode,
           CompanyAffiliation

    INTO TABLE @DATA(result).

    out->write( result ).

  ENDMETHOD.
ENDCLASS.
