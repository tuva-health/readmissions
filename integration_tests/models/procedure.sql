create or replace table core_readmissions_lean.procedure as
    (select encounter_id, code, code_type
     from  {{source('core','procedure')}})
