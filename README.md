Bios 611 Project
================
COVID-19 Analysis
------------------
Proposal
--------
### Introduction

The coronavirus pandemic is a result of the coronavirus disease (COVID-19) caused by the severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2), an RNA virus that has affected the lives of many individuals since its discovery late in 2019. 

There has been approximately 27 million reported cases of COVID-19 globally, with around 6.2 million of these cases located in the United States. Due to its potential for severe symptoms in affected individuals, the virus has been a subject of close study.

While we realize that the severity of symptoms can be different in each individual, we would like to better understand the possible causes for these variations. Using publicly available datasets, this project will try to find associations between patient pre-conditions or other characteristics and their susceptibility to the disease, which we will define as whether the patient later was registered as deceased. 

We are interested in knowing whether gender, certain chronic illnesses, behaviors such as smoking, or contact with COVID-19 affected individuals resulted in greater patient risk to severe symptoms of the disease, as well as whether different types of treatment (ICU, in/outpatient) influenced health outcomes. 

Descriptive statistics will take an initial look at some of these effects, and classification methods (logistic regression, trees) will deeper analyze what type of individuals are at a higher risk for more severe COVID-19 symptoms. A possible criteria for completion is building a model that can successfully predict whether an individual, given a list of pre-conditions or characteristics, is at lower or greater risk if affected by COVID-19.

### Datasets

The dataset contains observations of patients from Mexico, and can be found on [Kaggle](https://www.kaggle.com/tanmoyx/covid19-patient-precondition-dataset#). Potentially important variables to analyze include "patient_type", which describes whether the patient was given inpatient or outpatient care; date_symptoms, entry_date, and date_died for when a patient started showing symptoms, the day they were sought treatment, and if they later died from the disease, as well as chronic illness conditions such as diabetes, hypertension, etc. 

Two descriptive Excel files called "Description" and "Catalogs" contain the former variable names and instructions for interpretation of numeric values. 

### Preliminary Figures
<img src="figures/Patient_Type_Age.png" width="600">

As seen in the violin graph above, older patients are more likely to be sent to the hospital for inpatient care. This is reflected in older individuals also seeming to be the largest proportion of mortality cases at the hospital. Overall, older populations are more at risk for mortality due to the disease. 

<img src="figures/Wait_Time.png" width="600">

The above graph shows how patients who wait longer to be treated for the disease might have a similar mortality rate to those who received treatment earlier. There seems to be a slight difference, but is most likely not statistically significant. 

Because many of the precondition variables have only two options, we will visualize them with statistical models later in the project. 

Using this Project
-----------------

You will need Docker, and be able to run docker as your current user.

To build the container: 

    > docker build . -t project1-env
    
This Docker container is based on rocker/verse. Run rstudio server:
    
    > docker run -v `pwd`:/home/rstudio -p 8787:8787 -e PASSWORD=<yourpassword> -t project1-env
      
then connect to the machine on port 8787.

