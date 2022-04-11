[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![dbt logo and version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=0.21.x&color=orange)

# Readmissions 

Check out the latest [DAG](https://tuva-health.github.io/readmissions/#!/overview?g_v=1)

Check out the [Tuva Project Google Sheet](https://docs.google.com/spreadsheets/d/1q6VBqGJ3PBW0vYD1wrsN5jmcP0cEXQNd3xTyTgtHlcU/edit#gid=0)

Check out our [Docs](https://docs.tuvahealth.com/)

This package creates the CMS Hospital Wide Readmissions (HWR) measure.

There are main output tables from this package are:
1. `encounter_augmented`: lists all acute inpatient encounters with fields that give extra information about the encounter (e.g. length_of_stay, index_admission_flag, planned_flag, specialty_cohort, etc.), as well as data quality flags.
2. `readmission_summary`: lists all encounters that are not discarded due to data quality problems, together with fields giving extra information about the encounter and it's associated readmission (if the encounter had a readmission).

