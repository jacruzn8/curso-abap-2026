@AbapCatalog.sqlViewName: 'ZEMPL_V9'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Entity)'
@Metadata.ignorePropagatedAnnotations: true
define view Z_09_R_EMPLOYEE as select from z09_employ
association[1..1] to Z09_R_DEPARTMENT as _department
    on $projection.departmentid = _department.Id
{
    key employee_id as EmployeeId,
    first_name as FirstName,
    last_name as LastName,
    birth_date as BirthDate,
    entry_date as EntryDate,
    department_id  as departmentid,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    annual_salary as AnnualSalary,
    currency_code as CurrencyCode,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    _department
}
