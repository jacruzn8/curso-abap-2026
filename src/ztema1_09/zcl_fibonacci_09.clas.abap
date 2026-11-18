CLASS zcl_Fibonacci_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FIBONACCI_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  constants max_count type i value 20.
  DATA numbers TYPE table of i.
  DATA salida TYPE table of string.
  DATA(counter) = 0.



   DO max_count TIMES.
CASE sy-index.
      WHEN 1.
        APPEND 0 TO numbers.
      WHEN 2.
        APPEND 1 TO numbers.
      WHEN OTHERS.
          APPEND numbers[  sy-index - 2 ]
               + numbers[  sy-index - 1 ]
              TO numbers.
   ENDCASE.


ENDDO.


  LOOP AT numbers INTO DATA(number).

     counter = counter + 1.

     APPEND |{ counter WIDTH = 4 ALIGN = LEFT }: { number WIDTH = 10 ALIGN = RIGHT }|
         TO salida.

  ENDLOOP.


*  LOOP AT numbers.
*
*     counter = counter + 1.
*
*  ENDLOOP.


  out->write(
         data   = salida
         name   = |The first { max_count } Fibonacci Numbers|
                ) .


  ENDMETHOD.
ENDCLASS.
