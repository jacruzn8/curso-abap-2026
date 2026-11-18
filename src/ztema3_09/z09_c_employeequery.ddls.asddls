@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (query)'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z09_C_EmployeeQuery as select from Z_09_R_EMPLOYEE
{
    key EmployeeId,
    FirstName,
    LastName,
    BirthDate,
    EntryDate,
    departmentid,
    
    _department.Description as DepartmentDescription,
    _department._Assistant.LastName as AssistantName,
    
    @EndUserText.label: 'Employee Role'
     case EmployeeId
          when _department.HeadId      then 'H'
          when _department.AssistantId then 'A'
    else ' ' 
    end as EmployeeRole,
    
    @EndUserText.label: 'Monthly Salary'
    @Semantics.amount.currencyCode: 'CurrencyCode'
    cast( AnnualSalary as abap.fltp ) / 12.0 as MonthlySalary,
    CurrencyCode,
    
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    
    
    /* Associations */
    _department
}
