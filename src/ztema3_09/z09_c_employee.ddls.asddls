@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cONSULT cdS'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z09_C_EMPLOYEE as select from ZR09_EMPLOYEE
{
    key EmployeeId,
    FirstName,
    LastName,
    BirthDate,
    EntryDate,
    //ComponentToBeChanged,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt
}
