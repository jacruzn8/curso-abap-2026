@AbapCatalog: {
    dataMaintenance: #RESTRICTED,
    viewEnhancementCategory: [#PROJECTION_LIST],
    extensibility.dataSources: [ 'Employee' ],
    extensibility.elementSuffix: 'ZEM'
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'employee query CDS 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z09_C_EmployeeQuery3
    with parameters
        p_target_curr   : /dmo/currency_code,
        @EndUserText.label: 'Date of Evaluation'
        @Environment.systemField: #SYSTEM_DATE
        p_date          : abap.dats
  as select from Z_09_R_EMPLOYEE as Employee
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
  @Semantics.amount.currencyCode: 'CurrencyCode'
  currency_conversion( amount             => AnnualSalary,
                       source_currency    => CurrencyCode ,
                       target_currency    => $parameters.p_target_curr,
                       exchange_rate_date => $parameters.p_date, 
                       client             => $session.client,
                       error_handling     => 'SET_TO_NULL'
                     ) as AnnualSalaryConverted, 
   
  cast( AnnualSalary as abap.fltp ) / 12.0 as MonthlySalary,

  @EndUserText.label: 'Monthly Salary'
  @Semantics.amount.currencyCode: 'CurrencyCode'
  cast( $projection.AnnualSalaryConverted as abap.fltp )   / 12.0 as MonthlySalaryConverted,
      
//  MonthlySalary,
//  CurrencyCode,
    cast( 'USD' as /dmo/currency_code ) as CurrencyCodeUSD,
    $parameters.p_target_curr as CurrencyCode,
     
    
    division( dats_days_between( EntryDate, $parameters.p_date), 365, 1)   as CompanyAffiliation,
    
    /* Associations */
    _department
    
    
}
