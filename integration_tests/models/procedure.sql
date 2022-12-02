select encounter_id, code, code_type
     from  {{source('core','procedure')}}
