select encounter_id, patient_id,encounter_start_date,encounter_end_date,discharge_disposition_code
     ,facility_npi,ms_drg_code,encounter_type
from {{source('core','encounter')}}
