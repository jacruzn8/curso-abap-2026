CLASS LHC_ZR_09VEHICLE_BOOK DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Zr09vehicleBook
        RESULT result,
      calculateTotalDays FOR DETERMINE ON MODIFY
            keys FOR Zr09vehicleBook~calculateTotalDays,
      validateDates FOR VALIDATE ON SAVE
            keys FOR Zr09vehicleBook~validateDates,
      setInitialStatus FOR DETERMINE ON MODIFY
            keys FOR Zr09vehicleBook~setInitialStatus,
      cancelBooking FOR MODIFY
            keys FOR ACTION Zr09vehicleBook~cancelBooking RESULT result.
ENDCLASS.

CLASS LHC_ZR_09VEHICLE_BOOK IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD calculateTotalDays.

    " 1. Leer las reservas afectadas obteniendo las fechas de inicio y fin
    READ ENTITIES OF zr_09vehicle_book IN LOCAL MODE
      ENTITY Zr09vehicleBook
        FIELDS ( StartDate EndDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_bookings).

    DATA lt_update TYPE TABLE FOR UPDATE zr_09vehicle_book.

    " 2. Procesar cada registro y calcular los días
    LOOP AT lt_bookings INTO DATA(ls_booking).
      " Comprobar que ambas fechas tengan valor
      IF ls_booking-StartDate IS NOT INITIAL AND ls_booking-EndDate IS NOT INITIAL.
        " La resta entre tipos D (dats) devuelve la diferencia exacta en días
        DATA(lv_days) = ls_booking-EndDate - ls_booking-StartDate.

        " Preparar la estructura de actualización con la clave técnica (%tky)
        APPEND VALUE #(
          %tky      = ls_booking-%tky
          TotalDays = lv_days
        ) TO lt_update.
      ENDIF.
    ENDLOOP.

    " 3. Actualizar TotalDays en el buffer transaccional usando EML
    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF ZR_09VEHICLE_BOOK IN LOCAL MODE
        ENTITY Zr09vehicleBook
          UPDATE FIELDS ( TotalDays )
          WITH lt_update.
    ENDIF.


  ENDMETHOD.

  METHOD validateDates.

" 1. Leer las fechas introducidas en las reservas modificadas/creadas
    READ ENTITIES OF zr_09vehicle_book IN LOCAL MODE
      ENTITY Zr09vehicleBook
        FIELDS ( StartDate EndDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_bookings).

    " Obtener la fecha actual del sistema en ABAP Cloud
    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT lt_bookings INTO DATA(ls_booking).

      " Limpiar mensajes de estado previos del área de mensajes
      APPEND VALUE #( %tky        = ls_booking-%tky
                      %state_area = 'VALIDATE_DATES' ) TO reported-Zr09vehicleBook.

      " Validación 1: StartDate no sea anterior a la fecha actual
      IF ls_booking-StartDate IS NOT INITIAL AND ls_booking-StartDate < lv_today.
        APPEND VALUE #( %tky = ls_booking-%tky ) TO failed-Zr09vehicleBook.

        APPEND VALUE #( %tky               = ls_booking-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg               = new_message(
                                               id       = 'ZCM_09_VEHICLE_BOOK'
                                               number   = '001'
                                               severity = if_abap_behv_message=>severity-error
                                               v1       = ls_booking-StartDate )
                        %element-StartDate = if_abap_behv=>mk-on ) TO reported-Zr09vehicleBook.
      ENDIF.

      " Validación 2: EndDate no sea anterior a StartDate
      IF ls_booking-StartDate IS NOT INITIAL AND
         ls_booking-EndDate   IS NOT INITIAL AND
         ls_booking-EndDate < ls_booking-StartDate.

        APPEND VALUE #( %tky = ls_booking-%tky ) TO failed-Zr09vehicleBook.

        APPEND VALUE #( %tky               = ls_booking-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg               = new_message(
                                               id       = 'ZCM_09_VEHICLE_BOOK'
                                               number   = '005'
                                               severity = if_abap_behv_message=>severity-error
                                               v1       = ls_booking-EndDate
                                               v2       = ls_booking-StartDate )
                        %element-EndDate   = if_abap_behv=>mk-on ) TO reported-Zr09vehicleBook.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD setInitialStatus.

    " 1. Leer las reservas creadas que aún no tengan estado
    READ ENTITIES OF zr_09vehicle_book IN LOCAL MODE
      ENTITY Zr09vehicleBook
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_bookings).

    DATA lt_update TYPE TABLE FOR UPDATE zr_09vehicle_book.

    " 2. Asignar el estado inicial OPEN si el campo está vacío
    LOOP AT lt_bookings INTO DATA(ls_booking).
      IF ls_booking-Status IS INITIAL.
        APPEND VALUE #(
          %tky   = ls_booking-%tky
          Status = 'OPEN'
        ) TO lt_update.
      ENDIF.
    ENDLOOP.

    " 3. Actualizar el buffer transaccional
    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_09vehicle_book IN LOCAL MODE
        ENTITY Zr09vehicleBook
          UPDATE FIELDS ( Status )
          WITH lt_update.
    ENDIF.
  ENDMETHOD.

  METHOD cancelBooking.
   DATA lt_update TYPE TABLE FOR UPDATE zr_09vehicle_book.

   " 1. Leer las instancias seleccionadas por el usuario
   READ ENTITIES OF zr_09vehicle_book IN LOCAL MODE
     ENTITY Zr09vehicleBook
       FIELDS ( StartDate Status )
       WITH CORRESPONDING #( keys )
     RESULT DATA(lt_bookings).

   DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

   LOOP AT lt_bookings INTO DATA(ls_booking).

     " Validación 1: Verificar si ya está cancelada
     IF ls_booking-Status = 'CANCELLED'.
       APPEND VALUE #( %tky = ls_booking-%tky ) TO failed-Zr09vehicleBook.
       APPEND VALUE #(
         %tky = ls_booking-%tky
         %msg = new_message(
                  id       = 'ZCM_09_VEHICLE_BOOK'
                  number   = '002'
                  severity = if_abap_behv_message=>severity-error )
       ) TO reported-Zr09vehicleBook.
       CONTINUE.
     ENDIF.

     " Validación 2: Verificar si la fecha de inicio ya ha pasado
     IF ls_booking-StartDate IS NOT INITIAL AND ls_booking-StartDate < lv_today.
       APPEND VALUE #( %tky = ls_booking-%tky ) TO failed-Zr09vehicleBook.
       APPEND VALUE #(
         %tky = ls_booking-%tky
         %msg = new_message(
                  id       = 'ZCM_09_VEHICLE_BOOK'
                  number   = '004'
                  severity = if_abap_behv_message=>severity-error )
       ) TO reported-Zr09vehicleBook.
       CONTINUE.
     ENDIF.

     " Si cumple los requisitos, cambiar estado a CANCELLED
     APPEND VALUE #(
       %tky   = ls_booking-%tky
       Status = 'CANCELLED'
     ) TO lt_update.

     " Mensaje informativo de éxito (003)
     APPEND VALUE #(
       %tky = ls_booking-%tky
       %msg = new_message(
                id       = 'ZCM_09_VEHICLE_BOOK'
                number   = '003'
                severity = if_abap_behv_message=>severity-success )
     ) TO reported-Zr09vehicleBook.

   ENDLOOP.

   " 2. Modificar el estado en la base de datos
   IF lt_update IS NOT INITIAL.
     MODIFY ENTITIES OF zr_09vehicle_book IN LOCAL MODE
       ENTITY Zr09vehicleBook
         UPDATE FIELDS ( Status )
         WITH lt_update.
   ENDIF.

   " 3. Devolver los registros actualizados en la estructura RESULT
   READ ENTITIES OF zr_09vehicle_book IN LOCAL MODE
     ENTITY Zr09vehicleBook
       ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_updated_bookings).

   result = VALUE #( FOR booking IN lt_updated_bookings
                       ( %tky   = booking-%tky
                         %param = booking ) ).


  ENDMETHOD.

ENDCLASS.
