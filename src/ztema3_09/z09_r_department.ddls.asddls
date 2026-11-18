@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS with Associations'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z09_R_DEPARTMENT
  as select from z09_depment
  association [0..*] to Z_09_R_EMPLOYEE as _Employee
    on $projection.Id = _Employee.departmentid
  association [0..1] to Z_09_R_EMPLOYEE as _head
    on $projection.HeadId = _head.EmployeeId
  association [1..1] to Z_09_R_EMPLOYEE as _Assistant
    on $projection.AssistantId = _Assistant.EmployeeId
{
  key id                    as Id,
      description           as Description,
      head_id               as HeadId,
      assistant_id          as AssistantId,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt,
      _Employee,
      _head,
      _Assistant
}
