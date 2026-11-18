@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'employee query CDS 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z09_C_EmployeeQuery2 as select from Z_09_R_EMPLOYEE
{
    key EmployeeId,
    FirstName,
    LastName,
    departmentid,
//    DepartmentDescription,
   _department.Description as DepartmentDescription,
    
    _department._Assistant.LastName as AssistantName,
    concat_with_space( _department._Assistant.FirstName,
                       _department._Assistant.LastName, 
                       1 ) as AssistantName2,
                       
    
//    EmployeeRole,
  @EndUserText.label: 'Annual Salary'
  @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
  currency_conversion( amount             => AnnualSalary,
                       source_currency    => CurrencyCode ,
                       target_currency    => $projection.CurrencyCodeUSD,
                       exchange_rate_date => $session.system_date, 
                       client             => $session.client,
                       error_handling     => 'SET_TO_NULL'
                     ) as AnnualSalaryConverted, 
   
//    cast( AnnualSalary as abap.fltp ) / 12.0 as MonthlySalary,

  @EndUserText.label: 'Monthly Salary'
  @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
  cast( $projection.AnnualSalaryConverted as abap.fltp )   / 12.0 as MonthlySalary,
      
//  MonthlySalary,
//  CurrencyCode,
    cast( 'USD' as /dmo/currency_code ) as CurrencyCodeUSD,
     
    /* Associations */
    division( dats_days_between( EntryDate, $session.system_date), 365, 1)   as CompanyAffiliation,
    _department
    
    
}
