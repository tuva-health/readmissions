select patient_id,gender,birth_date
from {{source('core','patient')}}
