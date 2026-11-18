@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Task 4: Use an Outer Join'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z09_C_DeptQuery3_OuterJoin
with parameters
    p_target_curr : /dmo/currency_code,
    p_date        : abap.dats
as select from Z09_C_EmployeeQuery3( 
                 p_target_curr: $parameters.p_target_curr,
                 p_date:        $parameters.p_date 
               ) as e

    right outer join Z09_R_DEPARTMENT                      
        as d on e.departmentid = d.Id


{
  //    key EmployeeId,
  //    FirstName,
  //    LastName,
  d.Id,
  d.Description,
  avg( e.CompanyAffiliation as abap.dec(11,1) ) as AverageAffiliation,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  sum( e.AnnualSalaryConverted )                as TotalSalary,
  e.CurrencyCode
}
group by
  d.Id,
  d.Description,
  e.CurrencyCode


//      ,
//    AssistantName,
//    AssistantName2,
//    AnnualSalaryConverted,
//    MonthlySalary,
//    MonthlySalaryConverted,
//    CurrencyCodeUSD,
//    CurrencyCode,
//    CompanyAffiliation,
//    /* Associations */
//    _department
