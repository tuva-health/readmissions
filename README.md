[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![dbt logo and version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=1.x&color=orange)

# Hospital Readmissions 
This is the Tuva Project's Hospital Readmissions data mart, which is a dbt project to create readmission measures.  It is based on the [CMS Readmission Measures Methodology](https://qualitynet.cms.gov/inpatient/measures/readmission/methodology) and includes other features, such as data quality checks specific to readmissions.

Check out the [DAG](https://tuva-health.github.io/readmissions/#!/overview?g_v=1)

Knowledge Base:
- Check out the [methodology](https://thetuvaproject.com/docs/methodology/hospital-readmissions) used for the readmissions data mart
- Check our the [data model](https://thetuvaproject.com/docs/data-models/data-marts/readmissions) for the readmissions data mart

Videos:
- Check out this [high-level overview](https://www.youtube.com/watch?v=TCG_QCb63n4) of what it looks like to do proper readmission analytics
- Check out this [how to video](https://www.youtube.com/watch?v=5pA-gm94PyU) explaining how to run the readmissions data mart

## Pre-requisites
1. You have healthcare data (e.g. claims data) in a data warehouse (e.g. Snowflake)
2. You have [dbt](https://www.getdbt.com/) installed and configured (i.e. connected to your data warehouse)
3. Your healthcare data is in the proper format to run the readmissions data mart:
    - [Claims Preprocessing](https://github.com/tuva-health/claims_preprocessing_snowflake) will transform your claims data into the proper format
    - Alternatively you can map your data to the source schema described in [source.yml](models/_sources.yml)

[Here](https://docs.getdbt.com/dbt-cli/installation) are instructions for installing dbt.

## Getting Started
Complete the following steps to configure the data mart to run in your environment.

1. [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) this repo to your local machine or environment
2. Configure [dbt_project.yml](/dbt_project.yml)
    - Profile: set to 'default' by default - change this to an active profile in the profile.yml file that connects to your data warehouse 
    - Fill in the following vars (variables):
      - source_name - description of the dataset feeding this project 
      - input_database - database where sources feeding this project are stored 
      - input_schema - schema where sources feeding this project is stored 
      - output_database - database where output of this project should be written. We suggest using the Tuva database but any database will work. 
      - output_schema - name of the schema where output of this project should be written
3. Execute `dbt build` to load seed files, run models, and perform tests.

Alternatively you can execute the following code and skip step 2b and step 3:
```
dbt build --vars '{input_database: my_database, input_schema: my_input, output_database: my_other_database, output_schema: i_love_data}'
```

## Contributions
Have an opinion on the mappings? Notice any bugs when installing and running the package? 
If so, we highly encourage and welcome contributions!

## Community
Join our growing community of healthcare data practitioners on [Slack](https://join.slack.com/t/thetuvaproject/shared_invite/zt-16iz61187-G522Mc2WGA2mHF57e0il0Q)!

## Database Support
This package has been tested on Snowflake and Redshift.
