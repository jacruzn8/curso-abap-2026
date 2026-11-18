@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'Z09_VEHICLE_BOOK'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_09VEHICLE_BOOK
  provider contract transactional_query
  as projection on ZR_09VEHICLE_BOOK
  association [1..1] to ZR_09VEHICLE_BOOK as _BaseEntity on $projection.BookingID = _BaseEntity.BookingID
{
  key BookingID,
  CustomerName,
  Vehicle,
  StartDate,
  EndDate,
  Status,
  Totaldays,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  TotalPrice,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
 
  
// Ejercicio 4: Exponer el nuevo campo StatusCriticality,
-- Exposición del campo de criticidad para Fiori Elements

   StatusCriticality,
   
  @Semantics: {
    user.createdBy: true
  }
  Createdby,
  
  Createdat,
  @Semantics: {
    user.lastChangedBy: true
  }
  Lastchangedby,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  Lastchangedat,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Locallastchanged,
  _BaseEntity
}
