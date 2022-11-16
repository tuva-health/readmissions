
-- Staging model for the input layer:
-- stg_encounter input layer model.
-- This contains one row for every unique encounter in the dataset.


{{ config(materialize='view'
    ,enabled=var('readmissions_enabled',var('tuva_packages_enabled',True))) }}



select
    cast(encounter_id as varchar) as encounter_id,
    cast(patient_id as varchar) as patient_id,
    cast(encounter_start_date as date) as admit_date,
    cast(encounter_end_date as date) as discharge_date,
    cast(discharge_disposition_code as varchar) as discharge_disposition_code,
    cast(facility_npi as varchar) as facility_npi,
    cast(ms_drg_code as varchar) as ms_drg_code
    
from {{ var('encounter') }}
where encounter_type = 'acute inpatient'


