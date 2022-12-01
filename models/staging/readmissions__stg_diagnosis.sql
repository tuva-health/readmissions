
-- Staging model for the input layer:
-- stg_diagnosis input layer model.
-- This contains one row for every unique diagnosis each patient has.


{{ config(materialize='view'
    ,enabled=var('readmissions_enabled',var('tuva_packages_enabled',True))) }}



select
    cast(encounter_id as varchar) as encounter_id,
    cast(code as varchar) as diagnosis_code,
    cast(diagnosis_rank as integer) as diagnosis_rank

from {{var('condition')}}
where code_type = 'icd-10-cm' and condition_type = 'discharge diagnosis'


