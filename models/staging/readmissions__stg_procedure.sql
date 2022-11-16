
-- Staging model for the input layer:
-- stg_procedure input layer model.
-- This contains one row for every unique procedure each patient has.


{{ config(materialize='view'
    ,enabled=var('readmissions_enabled',var('tuva_packages_enabled',True))) }}



select
    cast(encounter_id as varchar) as encounter_id,
    cast(code as varchar) as procedure_code

from {{ var('procedure') }}
where code_type = 'icd-10-pcs'
