CLASS zcl_09_string_processing DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_09_STRING_PROCESSING IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  Select from /DMO/customer
  FIELDS customer_id,
         street && ',' && ' ' && postal_code && ' ' && city as  address_expr,
         concat(  street,
                   concat_with_space(  ',',
                           concat_with_space( postal_code,
                            upper( city ),
                            1
                            ),
                            1 ) ) as address_func
  where country_code = 'ES'
  INTO table @data(result_concat).

  out->write(
    EXPORTING
        data = result_concat
        name = 'RESULT_CONCAT'
        ).

**********************************************************************


    select from /dmo/carrier
    FIELDS carrier_id,
            name,
            upper( name ) as name_upper,
            lower( name ) as name_lower,
            initcap( name ) as name_initcap

    Where carrier_id = ' SR'
    into table @data(result_transform).

    out->write(
    EXPORTING
            data = result_transform
            name = 'RESULT_TRANSLATE'
            ).

**********************************************************************

    select from /dmo/flight
        FIELDS flight_date,
            cast( flight_date as char(  8 )  ) as flight_date_raw,
            left( flight_date, 4 ) as year,
            right( flight_date, 2 ) as day,
            substring( flight_date, 5, 2 ) as month

    where carrier_id = 'LH'
        and connection_id = '0400'
        into table @data(result_substring).

    out->write(
        EXPORTING
            data = result_substring
            name = 'RESULT_SUBSTRING' ).

  ENDMETHOD.
ENDCLASS.
