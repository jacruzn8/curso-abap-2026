CLASS zcl_fill_accounts_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FILL_ACCOUNTS_09 IMPLEMENTATION.


  method if_oo_adt_classrun~main.
    data:
     lt_accounts type table of ZTBL_ACCOUNTS_09.
     data counter type i.

     select count( * ) from ztbl_accounts_09 into @counter.

     "read current timestamp

     get TIME STAMP field data(zv_tsl).


     "fill internal table
     lt_accounts = VALUE #(
( client = '100' account_number = '00000001' bank_customer_id = '100001' bank_name = 'Volksbank' city = 'Gaertringen' balance = '200.00 ' currency = 'EUR'   account_category = '01' lastchangedat = zv_tsl )
( client = '100' account_number = '00000002' bank_customer_id = '200002' bank_name = 'Sparkasse' city = 'Schwetzingen' balance = '500.00 ' currency = 'EUR' account_category = '02' lastchangedat = zv_tsl )
( client = '100' account_number = '00000003' bank_customer_id = '200003' bank_name = 'Commerzbank' city = 'Nuernberg' balance = '150.00 ' currency = 'EUR' account_category = '02' lastchangedat = zv_tsl )

).

"Delete possible entries; insert new entries
DELETE FROM ztbl_accounts_09.

INSERT ztbl_accounts_09 from table @lt_accounts.

" Output all entries of lt_accounts
LOOP AT lt_accounts ASSIGNING FIELD-SYMBOL(<ls_account>).
  DATA(lv_line) = |Account: { <ls_account>-account_number }, | &&
                  |Customer: { <ls_account>-bank_customer_id }, | &&
                  |Bank: { <ls_account>-bank_name }, | &&
                  |City: { <ls_account>-city }, | &&
                  |Balance: { <ls_account>-balance }, | &&
                  |Currency: { <ls_account>-currency }, | &&
                  |Category: { <ls_account>-account_category }, | &&
                  |Last Change: { <ls_account>-lastchangedat }|.
  out->write( lv_line ).
ENDLOOP.


"Check result in console




out->write( sy-dbcnt ).

out->write(  'DONE!' ).

  endmethod.
ENDCLASS.
