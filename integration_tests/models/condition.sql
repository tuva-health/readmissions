select encounter_id, code, diagnosis_rank, code_type, condition_type
from {{source('core','condition')}}
