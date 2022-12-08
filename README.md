[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![dbt logo and version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=1.2.x&color=orange)

# Readmissions

## 🧰 What does this project do?

The Tuva Project's Readmissions package calculates hospital readmission measures on your healthcare data.  

For a detailed overview of the methodology used in the package check out our [Knowledge Base](https://thetuvaproject.com/docs/packages/readmissions).  

For information on data models and to view the entire DAG check out our dbt [Docs](https://tuva-health.github.io/readmissions/#!/overview).

## 🔌 What databases are supported?

This package has been tested on **Snowflake** and **Redshift**.

## 📚 What versions of dbt are supported?

This package requires you to have dbt installed and a functional dbt project running on dbt version `1.2.x` or higher.

## ✅ How do I use this dbt package?

Below are the steps to run this individual dbt package.  To run all packages in The Tuva Project, please refer to this [README](https://github.com/tuva-health/the_tuva_project#readme).

### Overview

The Tuva Project is a collection of dbt packages that build healthcare concepts (measures, groupers, data quality tests) on top of your raw healthcare data. Each of these dbt packages expects you to have data in a certain format (specific tables with specific columns in them) and uses that as an input to then build healthcare concepts. To run any dbt package that is part of The Tuva Project, the basic idea is the same:

1. You create the necessary input tables as models within your dbt project so that the Tuva package of interest can reference them using ref() functions.
2. You import the Tuva package you are interested in and tell it where to find the relevant input tables as well as what database and schema to dump its output into.

### **Step 1:**

First you must create the necessary input tables as models within your dbt project so that the Tuva package of interest can reference them using ref() functions. To run this Readmissions package, you must create [these 4 tables](https://tuva-health.github.io/readmissions/#!/model/model.readmissions_input.condition) as models within your dbt project.

### **Step 2:**

Once you have created the necessary 4 input tables as models within your dbt project, the next step is to import the Readmissions dbt package and tell it where to find the relevant input tables as well as what database and schema to dump its output into. These things are done by editing 2 different files in your dbt project: `packages.yml` and `dbt_project.yml`. 

To import the Readmissions package, you need to include the following in your `packages.yml`:

```yaml
packages:
  - package: tuva-health/readmissions
    version: 0.1.4

```

To tell the Readmissions package where to find the relevant input tables as well as what database and schema to dump its output into, you must add the following in your `dbt_project.yml:`

```yaml
vars:
# These variables point to the 4 input tables you created 
# in your dbt project. The Readmissions package will use
# these 4 tables as input to build the Readmission Measures.
# If you named these 4 models anything other than 'patient',
# 'encounter', 'condition', 'procedure', you must modify the
# refs here:
  core_patient_override:   "{{ref('patient')}}"
  core_encounter_override: "{{ref('encounter')}}"
  core_condition_override: "{{ref('condition')}}"
  core_procedure_override: "{{ref('procedure')}}"

# These variables name the database and schemas that the
# output of the Readmissions package will be dumped into:
  tuva_database:  tuva     # make sure this database exists in your data warehouse
  readmissions_schema: readmissions
  terminology_schema: terminology

# By default, the Readmissions package will import all
# Tuva Terminology files. If you are running the Readmissions
# package alone, we recommend including these vars here
# to import only the Tuva Terminology files relevant
# for Readmissions:
  tuva_packages_enabled: false	    
  readmissions_enabled: true       

# By default, dbt prefixes schema names with the target 
# schema in your profile. We recommend including this 
# here so that dbt does not prefix the 'readmissions' schema
# with anything:
dispatch:
  - macro_namespace: dbt
    search_order: [ 'readmissions', 'dbt']
```

After completing the above steps you’re ready to run your project:

- Run `dbt deps` to install the package
- Run `dbt build` to run the entire project

You now have the readmissions tables in your database and are ready to do analytics!

## 🙋🏻‍♀️ ****How is this package maintained and how do I contribute?****

The Tuva Project team maintaining this package **only** maintains the latest version of the package. We highly recommend you stay consistent with the latest version.

Have an opinion on the mappings? Notice any bugs when installing and running the package? If so, we highly encourage and welcome feedback! While we work on a formal process in Github, we can be easily reached in our Slack community.

## 🤝 Join our community!

Join our growing community of healthcare data practitioners in [Slack](https://join.slack.com/t/thetuvaproject/shared_invite/zt-16iz61187-G522Mc2WGA2mHF57e0il0Q)!
