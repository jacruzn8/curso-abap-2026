@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Task 3: Supply Input Parameters'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z09_C_DepartmentQuery3 
    with parameters
        p_target_curr   :   /dmo/currency_code,
        @EndUserText.label: 'Date of evaluation'
        @Environment.systemField: #SYSTEM_DATE
        p_date        : abap.dats
as     select from Z09_C_EmployeeQuery3( p_target_curr: $parameters.p_target_curr, p_date: $parameters.p_date )
{
//    key EmployeeId,
//    FirstName,
//    LastName,
    departmentid,
    DepartmentDescription,
     avg( CompanyAffiliation as abap.dec(11,1) ) as AverageAffiliation,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  sum( AnnualSalaryConverted )               as TotalSalary,
  CurrencyCode
    
//    AssistantName,
//    AssistantName2,
//    @EndUserText.label: 'Annual Salary'
//    @Semantics.amount.currencyCode: 'CurrencyCode'
//    AnnualSalaryConverted,
//    MonthlySalary,
//    CurrencyCodeUSD,
//    CompanyAffiliation,
//    /* Associations */
//    _department
}
group by
    departmentid,
    DepartmentDescription,
    CurrencyCode
