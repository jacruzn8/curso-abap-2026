@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'Z09_VEHICLE_BOOK'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_09VEHICLE_BOOK
  as select from z09_vehicle_book
{
  key booking_id as BookingID,
  custonmer_name as CustomerName,
  vehicle as Vehicle,
  start_date as StartDate,
  end_date as EndDate,
  status as Status,
  totaldays as Totaldays,
  @Semantics.amount.currencyCode: 'Currency'
  total_price as TotalPrice,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
  
//  Ejercicio 4: Incoporar campos calculado con sentencia CASE. 
//   Campo calculado para la criticidad semántica en Fiori Elements
//      case status
//        when 'OPEN'      then cast( 3 as abap.int1 )
//        when 'CANCELLED' then cast( 1 as abap.int1 )
//        else                  cast( 0 as abap.int1 )
//      end              as StatusCriticality,
//      
      
   case status
      when 'CANCELLED' then 1  // Rojo
      when 'PENDING'   then 2  // Naranja/Amarillo
      when 'OPEN'      then 3  // Verde
      when 'NEW'       then 5  // Azul
      else                  0  // Neutral (Gris)
    end as StatusCriticality,
      
  @Semantics.user.createdBy: true
  createdby as Createdby,
  createdat as Createdat,
  @Semantics.user.lastChangedBy: true
  lastchangedby as Lastchangedby,
  @Semantics.systemDateTime.lastChangedAt: true
  lastchangedat as Lastchangedat,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchanged as Locallastchanged
}
