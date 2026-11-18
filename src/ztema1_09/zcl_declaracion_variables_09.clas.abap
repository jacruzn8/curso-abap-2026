CLASS zcl_declaracion_variables_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DECLARACION_VARIABLES_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  declare dos variables para valores enteros (nombres sugeridos: number1 y number2 ).

    DATA number1 TYPE i.
    DATA number2 TYPE i.

    DATA result TYPE p LENGTH 8 DECIMALS 2.


*  Implementa una asignación de valor para cada una de las dos variables numéricas.
*  Asigna un valor negativo a la primera variable y un valor positivo a la segunda.
*
    number1 = -8.
    number2 =  3.

*  1.- Implementa una expresión aritmética que calcule la razón entre los dos números.
*   Almacena el resultado en una variable que declares mediante una declaración en línea

*    DATA(result) = number1 / number2.
result = number1 / number2.

*  2.-Implementa una plantilla de cadena que construya un texto como este: "6 / 3 = 2",
*Almacena el resultado en una variable que declares usando una declaración en línea
*(nombre sugerido: output ).

    DATA(output) = |{ number1 } / { number2 } = { result }|.

*  3.-Muestra el resultado por pantalla

    out->write( output ).


  ENDMETHOD.
ENDCLASS.
