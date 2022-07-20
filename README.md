[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![dbt logo and version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=1.x&color=orange)

# Readmissions 

Check out the [Tuva Data Model](https://docs.google.com/spreadsheets/d/1NuMEhcx6D6MSyZEQ6yk0LWU0HLvaeVma8S-5zhOnbcE/edit#gid=1991587675)

Check out the latest [DAG](https://tuva-health.github.io/readmissions/#!/overview?g_v=1) for this concept

Check out our [Docs](http://thetuvaproject.com/)

Other links of interest related to this concept:

- Short video giving a [high-level overview](https://www.youtube.com/watch?v=TCG_QCb63n4)
  of what it looks like to do proper analytics on hospital readmissions

- [Video explanation](https://www.youtube.com/watch?v=5pA-gm94PyU)
  of how to run this readmissions dbt project

This is Tuva Project's Readmissions concept, which is a dbt project to do hospital readmission analytics.
It is based on the [CMS Readmission Measures Methodology](https://qualitynet.cms.gov/inpatient/measures/readmission/methodology) and includes other features, such as data quality checks specific to readmissions.

The main output tables from this dbt project are:
1. `encounter_augmented`: lists all acute inpatient encounters with fields that give extra information about the encounter (e.g. length_of_stay, index_admission_flag, planned_flag, specialty_cohort, etc.), as well as data quality flags.
2. `readmission_summary`: lists all encounters that are not discarded due to data quality problems, together with fields giving extra information about the encounter and it's associated readmission (if the encounter had a readmission).

## Pre-requisites
1. You have healthcare data (e.g. EHR, claims, lab, HIE, etc.) in a data warehouse.
2. You have run one of the Tuva Project's connectors or preprocessing projects ([claims_preprocessing_snowflake](https://github.com/tuva-health/claims_preprocessing_snowflake), [claims_preprocessing_redshift](https://github.com/tuva-health/claims_preprocessing_redshift), etc.) to transform your data. 
Alternatively, you can directly map your data to the source schema described in [source.yml](models/source.yml).
3. You have [dbt](https://www.getdbt.com/) installed and configured (i.e. connected to your data warehouse).

[Here](https://docs.getdbt.com/dbt-cli/installation) are instructions for installing dbt.

## Getting Started
Complete the following steps to configure the package to run in your environment.

1. [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) this repo to your local machine or environment
2. Configure [dbt_project.yml](/dbt_project.yml)
    - Profile: set to 'tuva' by default - change this to an active profile in the profile.yml file that connects to your data warehouse 
    - Fill in vars (variables):
      - source_name - description of the dataset feeding this project 
      - input_database - database where sources feeding this project are stored 
      - input_schema - schema where sources feeding this project is stored 
      - output_database - database where output of this project should be written. We suggest using the Tuva database but any database will work. 
      - output_schema - name of the schema where output of this project should be written
3. Review [sources.yml](models/sources.yml). The table names listed are the same as in the Tuva data model (linked above).  If you decided to rename these tables:
    - Update table names in sources.yml
4. Execute `dbt build` to load seed files, run models, and perform tests.

## Usage Example
Sample dbt command specifying new variable names dynamically:

```
dbt build --vars '{input_database: my_database, input_schema: my_input, output_database: my_other_database, output_schema: i_love_data}'
```

## Contributions
Have an opinion on the mappings? Notice any bugs when installing and running the package? 
If so, we highly encourage and welcome contributions!

Join the conversation on [Slack](https://tuvahealth.slack.com/ssb/redirect#/shared-invite/email)!

## Database Support
This package has been tested on Snowflake and Redshift.
