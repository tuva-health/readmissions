
-- Here we list the specialty cohort for each encounter that has
-- an associated specialty cohort.
-- There are 5 possible specialty cohorts:
--      [1] Medicine
--      [2] Surgery/Gynecology
--      [3] Cardiology
--      [4] Cardiovascular
--      [5] Neurology
-- An encounter that has an ICD-10-PCS procedure code or a
-- CCS procedure category that corresponds to the
-- 'Surgery/Gynecology' cohort will always be in that cohort.
-- For encounters that are not in the 'Surgery/Gynecology' cohort,
-- we then check to see if they are in one of the other 4 cohorts.


{{ config(materialized='view'
    ,enabled=var('readmissions_enabled',var('tuva_packages_enabled',True))) }}

/*

-- All encounter_ids that have an ICD-10-PCS procedure code
-- or a CCS procedure category that corresponds to the
-- 'Surgery/Gynecology' cohort
with surgery_gynecology as (
select distinct encounter_id
from {{ ref('readmissions__procedure_ccs') }}
where
    procedure_code in (select distinct icd_10_pcs
                       from {{ ref('terminology__surgery_gynecology_cohort') }} )
    or
    ccs_procedure_category in
           (select distinct ccs
            from {{ ref('terminology__specialty_cohort') }} sgsc
	    where sgsc.specialty_cohort = 'Surgery/Gynecology' )
),


-- All encounter_ids that are not in the 'Surgery/Gynecology' cohort
-- and are in the 'Medicine' cohort
medicine as (
select distinct encounter_id
from {{ ref('readmissions__diagnosis_ccs') }}
where
    encounter_id not in (select * from surgery_gynecology)
    and
    ccs_diagnosis_category in
           (select distinct ccs
            from {{ ref('terminology__specialty_cohort') }} msc
	    where msc.specialty_cohort = 'Medicine' )
),


-- All encounter_ids that are not in the 'Surgery/Gynecology' cohort
-- and are in the 'Cardiorespiratory' cohort
cardiorespiratory as (
select distinct encounter_id
from {{ ref('readmissions__diagnosis_ccs') }}
where
    encounter_id not in (select * from surgery_gynecology)
    and
    ccs_diagnosis_category in
           (select distinct ccs
            from {{ ref('terminology__specialty_cohort') }} crsc
	    where crsc.specialty_cohort = 'Cardiorespiratory' )
),


-- All encounter_ids that are not in the 'Surgery/Gynecology' cohort
-- and are in the 'Cardiovascular' cohort
cardiovascular as (
select distinct encounter_id
from {{ ref('readmissions__diagnosis_ccs') }}
where
    encounter_id not in (select * from surgery_gynecology)
    and
    ccs_diagnosis_category in
           (select distinct ccs
            from {{ ref('terminology__specialty_cohort') }} cvsc
	    where cvsc.specialty_cohort = 'Cardiovascular' )
),


-- All encounter_ids that are not in the 'Surgery/Gynecology' cohort
-- and are in the 'Neurology' cohort
neurology as (
select distinct encounter_id
from {{ ref('readmissions__diagnosis_ccs') }}
where
    encounter_id not in (select * from surgery_gynecology)
    and
    ccs_diagnosis_category in
           (select distinct ccs
            from {{ ref('terminology__specialty_cohort') }} nsc
	    where nsc.specialty_cohort = 'Neurology' )
),


-- All encounter_ids that have an associated cohort listed
-- with their corresponding cohort
all_cohorts as (
select encounter_id, 'Surgery/Gynecology' as specialty_cohort
from surgery_gynecology
union distinct
select encounter_id, 'Medicine' as specialty_cohort
from medicine
union distinct
select encounter_id, 'Cardiorespiratory' as specialty_cohort
from cardiorespiratory
union distinct
select encounter_id, 'Cardiovascular' as specialty_cohort
from cardiovascular
union distinct
select encounter_id, 'Neurology' as specialty_cohort
from neurology
),


-- Assign a specialty cohort to ALL encounters. If an encounter
-- does not belong to any specialty cohort according to the
-- rules above, then it is assigned to the 'Medicine' cohort
-- by default
cohorts_for_all_encounters as (
select
    aa.encounter_id,
    case
        when bb.specialty_cohort is not null then bb.specialty_cohort
	else 'Medicine'
    end as specialty_cohort
from {{ ref('readmissions__stg_encounter') }} aa
     left join all_cohorts bb on aa.encounter_id = bb.encounter_id
)



select *
from cohorts_for_all_encounters

*/

with cohort_ranks as (
    select 'Surgery/Gynecology' as cohort, 1 as c_rank
    union all
    select 'Cardiorespiratory' as cohort, 2 as c_rank
    union all
    select 'Cardiovascular' as cohort, 3 as c_rank
    union all
    select 'Neurology' as cohort, 4 as c_rank
    union all
    select 'Medicine' as cohort, 5 as c_rank
)

, all_encounter_cohorts as (
    select proc.encounter_id, 1 as c_rank
    from {{ ref('readmissions__procedure_ccs') }} proc
    left join {{ ref('terminology__surgery_gynecology_cohort') }} sgc
        on proc.procedure_code = sgc.icd_10_pcs
    left join {{ ref('terminology__specialty_cohort') }} sgsc
        on proc.ccs_procedure_category = sgsc.ccs
    where sgc.icd_10_pcs is not null or sgsc.ccs is not null

    union all

    select diag.encounter_id, cohort_ranks.c_rank
    from {{ ref('readmissions__diagnosis_ccs') }} diag
    inner join {{ ref('terminology__specialty_cohort') }} sc
        on diag.ccs_diagnosis_category = sc.ccs and sc.procedure_or_diagnosis = 'Diagnosis'
    inner join cohort_ranks
        on sc.specialty_cohort = cohort_ranks.cohort
)

, main_encounter_cohort as (
    select encounter_id, min(c_rank) as main_c_rank
    from all_encounter_cohorts
    group by encounter_id

)

select enc.encounter_id, coalesce(cohort_ranks.cohort, 'Medicine') as specialty_cohort
from {{ ref('readmissions__stg_encounter') }} enc
left join main_encounter_cohort mec
    on enc.encounter_id = mec.encounter_id
left join cohort_ranks
    on mec.main_c_rank = cohort_ranks.c_rank