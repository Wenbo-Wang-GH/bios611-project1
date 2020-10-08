Bios 611 - Project 1
====================
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

The dataset contains observations of patients from Mexico, and can be found on [Kaggle](https://www.kaggle.com/tanmoyx/covid19-patient-precondition-dataset#). Potentially important variables to analyze for addressing our questions include "patient_type", which describes whether the patient was given inpatient or outpatient care; date_symptoms, entry_date, and date_died for when a patient started showing symptoms, the day they were sought treatment, and if they later died from the disease, as well as chronic illness conditions such as diabetes, hypertension, etc. 

Two descriptive Excel files called "Description" and "Catalogs" contain the former variable names and instructions for interpretation of numeric values. 

### Preliminary Figures
<img src="figures/Patient_Type_Age.png" width="600">

As seen in the violin graph above, where 0 represents an alive patient, older patients are more likely to be sent to the hospital for inpatient care. This is reflected in older individuals also seeming to be the largest proportion of mortality cases at the hospital. Overall, older populations are more at risk for mortality due to the disease. 

<img src="figures/Wait_Time.png" width="600">

The above graph shows how patients who wait longer to be treated for the disease might have a similar mortality rate to those who received treatment earlier. There seems to be a slight difference, but is most likely not statistically significant. 

Because many of the precondition variables have only two options, we will visualize them with statistical models later in the project. 

From logistic regression models, we have the following results below (which can also be found in the derived data file). From the results, we can see that many pre-existing health conditions are significant for predicting patient mortality. For baseline of a yes or female response, 2 represents a no or male response while 97-99 represent no response or not applicable. The model summary shows that the log odds of mortality increases by around 1.19 for males than females when other variables are held constant, and pre-existing or health conditions that increase odds of mortality include hypertension and obesity, as well as being on immunosuppression or at the icu. Surprisingly, patients with no copd, no asthma, not pregnant, no patterns of smoking, or had no previous contact with individuals diagnosed with COVID-19 had a significantly higher chance for mortality than reference groups. While not applicable coefficients are usually not significant, not applicable responses for being admitted to the icu is a very strong predictor for lower mortality rates; this might suggest that patients not considering entering the icu are usually healthy, which is supported by how patients in the icu had higher odds for mortality. 

<pre>
Call:
glm(formula = dependent ~ age + sex + diabetes + pregnancy + 
    copd + asthma + inmsupr + hypertension + +cardiovascular + 
    obesity + renal_chronic + tobacco + contact_other_covid + 
    icu, family = binomial, data = covid)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.1423  -0.1730  -0.1131  -0.0791   3.7173  

Coefficients: (1 not defined because of singularities)
                        Estimate Std. Error  z value Pr(>|z|)    
(Intercept)           -3.8614160  0.1669945  -23.123  < 2e-16 ***
age                    0.0388723  0.0004347   89.425  < 2e-16 ***
sex2                   1.1882937  0.1488188    7.985 1.41e-15 ***
diabetes2             -0.2631437  0.0148762  -17.689  < 2e-16 ***
diabetes98            -0.4663109  0.1769408   -2.635  0.00840 ** 
pregnancy2             0.7761665  0.1490542    5.207 1.92e-07 ***
pregnancy97                   NA         NA       NA       NA    
pregnancy98            0.7418533  0.2373244    3.126  0.00177 ** 
copd2                  0.1509143  0.0305768    4.936 7.99e-07 ***
copd98                 0.5581798  0.2250628    2.480  0.01313 *  
asthma2                0.2356545  0.0437795    5.383 7.34e-08 ***
asthma98               0.5412827  0.2648831    2.043  0.04101 *  
inmsupr2              -0.1650241  0.0354399   -4.656 3.22e-06 ***
inmsupr98             -0.5122827  0.1983653   -2.583  0.00981 ** 
hypertension2         -0.0765228  0.0151134   -5.063 4.12e-07 ***
hypertension98        -0.1748154  0.2180001   -0.802  0.42261    
cardiovascular2        0.1515441  0.0291712    5.195 2.05e-07 ***
cardiovascular98       0.5151896  0.2187306    2.355  0.01850 *  
obesity2              -0.3152545  0.0157464  -20.021  < 2e-16 ***
obesity98              0.0852469  0.1367230    0.624  0.53296    
renal_chronic2        -0.2704169  0.0271957   -9.943  < 2e-16 ***
renal_chronic98       -0.3796233  0.2219459   -1.710  0.08719 .  
tobacco2               0.1262334  0.0228479    5.525 3.30e-08 ***
tobacco98              0.0921903  0.1819535    0.507  0.61239    
contact_other_covid2   0.4732631  0.0223792   21.147  < 2e-16 ***
contact_other_covid99  1.1042245  0.0213054   51.828  < 2e-16 ***
icu2                  -0.9786666  0.0240525  -40.689  < 2e-16 ***
icu97                 -3.8477852  0.0284016 -135.478  < 2e-16 ***
icu99                  0.2671810  0.1963099    1.361  0.17351    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 267710  on 563200  degrees of freedom
Residual deviance: 163292  on 563173  degrees of freedom
AIC: 163348

Number of Fisher Scoring iterations: 7
</pre>


Using this Project
-----------------

You will need Docker, and be able to run docker as your current user.

To build the container: 

    > docker build . -t project1-env
    
This Docker container is based on rocker/verse. Run rstudio server:
    
    > docker run -v `pwd`:/home/rstudio -p 8787:8787 -e PASSWORD=<yourpassword> -t project1-env
      
then connect to the machine on port 8787.

