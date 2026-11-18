@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search: { searchable: true }
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'Z09GROCERY'
}
define root view entity ZC_09GROCERY
  provider contract transactional_query
  as projection on ZR_09GROCERY
  association [1..1] to ZR_09GROCERY as _BaseEntity on $projection.ID = _BaseEntity.ID
{
  key ID,
  @Search.defaultSearchElement: true
  Product,
  @Search.defaultSearchElement: true
  Category,
  @Search.defaultSearchElement: true
  Brand,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  Price,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
  Quantity,
  Purchasedate,
  @Search.defaultSearchElement: true
  Expirationdate,
  @Search.defaultSearchElement: true
  Expired,
  @Search.defaultSearchElement: true
  Rating,
  Note,
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
