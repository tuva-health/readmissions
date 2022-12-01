select encounter_id, CODE, DIAGNOSIS_RANK, code_type, condition_type
from {{source('core','condition')}}