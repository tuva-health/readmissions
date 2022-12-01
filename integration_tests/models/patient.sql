select PATIENT_ID,GENDER,BIRTH_DATE
from {{source('core','patient')}}