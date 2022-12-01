# Readmissions

## 🧰 What does this project do?

The Tuva Project's Readmissions data mart creates readmission flags on your patient population.  For a detailed overview of what the project does and how it works, check out our [Knowledge Base](https://thetuvaproject.com/docs/methodology/hospital-readmissions).  For information on data models and to view the entire DAG check out our dbt [Docs](https://tuva-health.github.io/readmissions/#!/overview).

## 🔌 Database Support

This package has been tested on **Snowflake** and **Redshift**.

## ✅ How to get started

The steps below are to install this individual package.  To install all packages in The Tuva Project, please refer to [that ReadMe](https://hub.getdbt.com/tuva-health/the_tuva_project/latest/).

### Step 1: Pre-requisites

To use this dbt package, you must have the following:

- **Database**:  This package creates and transforms data in a database called Tuva
- **Dataset**: Claims data is available in your warehouse mapped to these 19 columns
- **dbt version**:  This package requires you to have dbt installed and a functional dbt project running on version `1.2.x`.

### **Step 2: Package Installation**

Include the following in your `packages.yml`:

```yaml
packages:
  - package: tuva-health/readmissions
    version: 0.1.4

```

Please refer to [dbt Hub](https://hub.getdbt.com/) or read the [dbt docs](https://docs.getdbt.com/docs/build/packages) for the latest information on installing packages.

### **Step 3: Configure input**

By default, this package will use the claims data created by your dbt project (i.e. the data in the target database and schema in your `dbt_project.yml`).  However, you will need to configure the models that the package will reference by adding these variables to your `dbt_project.yml`:

```yaml
vars:
  core_condition_override: "{{ref('condition')}}"
  core_patient_override:   "{{ref('patient')}}"
  core_encounter_override: "{{ref('encounter')}}"
  core_procedure_override: "{{ref('procedure')}}"
```

### **Step 4: Enabling/Disabling Models**

This package is dependent on the [Terminology](https://hub.getdbt.com/tuva-health/terminology/latest/) package but no separate installation is required.  By default, all seed files in the Terminology package will be loaded.  To only load the required terminology seeds, include the following in your `dbt_project.yml`

```yaml
vars:
  terminology_enabled: false        #by default true
```

### **(Optional) Step 5: Change build schema and database**

By default, this package will build all models in a database called `Tuva`. The schema names reflect the package name (i.e. readmissions). This behavior can be altered by adding these variables to your `dbt_project.yml`:

```yaml
vars:
  readmissions_database: tuva
  readmissions_schema: readmissions
```

## 🙋🏻‍♀️ ****How is this package maintained and can I contribute?****

The Tuva Project team maintaining this package **only** maintains the latest version of the package. We highly recommend you stay consistent with the latest version.

### **Contributions**

Have an opinion on the mappings? Notice any bugs when installing and running the package? If so, we highly encourage and welcome feedback! While we work on a formal process in Github, we can be easily reached in our Slack community.

## 🤝 Community

Join our growing community of healthcare data practitioners in [Slack](https://join.slack.com/t/thetuvaproject/shared_invite/zt-16iz61187-G522Mc2WGA2mHF57e0il0Q)!
