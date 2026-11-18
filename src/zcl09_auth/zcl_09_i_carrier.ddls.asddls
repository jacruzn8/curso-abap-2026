//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Carrier View Entity'
//@Search.searchable: true
//
//
//define view entity ZCL_09_I_CARRIER
//  as select from /dmo/carrier as Airline
//  
////  association [0..1] to I_Currency as _currency 
////    on $projection.CurrencyCode = _currency.Currency
//{
//@Search.defaultSearchElement: true
////  @ObjectModel.text.element: ['Name']
//  key Airline.carrier_id    as AirlineID,
//      
//      Airline.name          as Name,
//      Airline.currency_code as CurrencyCode
//      
//      /* Campos de control */
//      Airline.local_created_at      as LocalCreatedAt,
//      Airline.local_created_by      as LocalCreatedBy,
//      Airline.local_last_changed_at as LocalLastChangedAt,
//      Airline.local_last_changed_by as LocalLastChangedBy,
//      
//      /* Associations */
//      _currency
//}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Carrier View - CDS Data Model'

@Search.searchable: true

define view entity ZCL_09_I_CARRIER
  as select from /dmo/carrier as Airline

  association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency

{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['Name']
  key Airline.carrier_id    as AirlineID,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Semantics.text: true
      Airline.name          as Name, 

      Airline.currency_code as CurrencyCode,

      last_changed_at       as LastChangedAt,
      local_created_at      as LocalCreatedAt,
      local_created_by      as LocalCreatedBy,
      local_last_changed_at as LocalLastChangedAt,
      local_last_changed_by as LocalLastChangedBy,

      /* Associations */
      _Currency
}
