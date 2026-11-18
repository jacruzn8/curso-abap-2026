@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Process Data Sets in CDS Views'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z09_C_DepartmentQuery
  as select from Z09_C_EmployeeQuery2
{
//  key EmployeeId,
//      FirstName,
//      LastName,
      departmentid as ID,
      DepartmentDescription,
      avg( CompanyAffiliation as abap.dec(11,1) ) as AverageAffiliation,
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      sum( AnnualSalaryConverted ) as TotalSalary,
      CurrencyCodeUSD
//      ,
//      AssistantName,
//      AssistantName2,
//      AnnualSalaryConverted,
//      MonthlySalary,
//      MonthlySalaryConverted,
//      CurrencyCodeUSD,
//      CurrencyCode,
//      CompanyAffiliation,
//      
//      /* Associations */
//      _department
}
group by
    departmentid,
    DepartmentDescription,
    CurrencyCodeUSD

