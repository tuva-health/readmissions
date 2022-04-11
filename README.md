[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![dbt logo and version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=0.21.x&color=orange)

# Readmissions 

Check out the latest [DAG](https://tuva-health.github.io/readmissions/#!/overview?g_v=1)

Check out the [Tuva Project Google Sheet](https://docs.google.com/spreadsheets/d/1q6VBqGJ3PBW0vYD1wrsN5jmcP0cEXQNd3xTyTgtHlcU/edit#gid=0)

Check out our [Docs](https://docs.tuvahealth.com/)

This package creates the CMS Hospital Wide Readmissions (HWR) measure.

There are main output tables from this package are:
1. `encounter_augmented`: lists all acute inpatient encounters with fields that give extra information about the encounter (e.g. length_of_stay, index_admission_flag, planned_flag, specialty_cohort, etc.), as well as data quality flags.
2. `readmission_summary`: lists all encounters that are not discarded due to data quality problems, together with fields giving extra information about the encounter and it's associated readmission (if the encounter had a readmission).

## Pre-requisites
1. You have healthcare data (e.g. EHR, claims, lab, HIE, etc.) in a data warehouse
2. You have [dbt](https://www.getdbt.com/) installed and configured (i.e. connected to your data warehouse)

[Here](https://docs.getdbt.com/dbt-cli/installation) are instructions for installing dbt.

## Configuration
Execute the following steps to load all seed files, build all data marts, and run all data quality tests in your data warehouse:

1. [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) this repo to your local machine or environment
2. This project will run automatically off of [Tuva Core](https://github.com/tuva-health/core).
3. Alternatively, if you haven't installed Tuva Core you can directly map your data to the source schema described in [source.yml](models/source.yml)
4. Configure [dbt_project.yml](/dbt_project.yml)
    - profile: write the name of the profile in the profile.yml file that connects to your data warehouse
    - vars: configure source_name, source_database name, and source_schema name
5. Run project
    1. Navigate to the project directory in the command line
    2. Execute "dbt build" to create all tables/views in your data warehouse

## Contributions
Don't see a model or specific metric you would have liked to be included? Notice any bugs when installing 
and running the package? If so, we highly encourage and welcome contributions to this package! 

Join the conversation on [Slack](https://tuvahealth.slack.com/ssb/redirect#/shared-invite/email)!

## Database Support
This package has been tested on Snowflake and Redshift.  We are planning to expand testing to BigQuery in the near future.
