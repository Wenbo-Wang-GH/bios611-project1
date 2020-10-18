derived_data/covid.csv derived_data/covid_dup.csv:
 source_data/covid.csv\
 tidy_source_data.R
	Rscript tidy_source_data.R 
	
figures/Patient_Type_Age.png:
 derived_data/covid.csv\
	patient_type_vs_age.R

figures/Wait_Time.png:
 derived_data/covid.csv\
	wait_time.R

derived_data/lm.txt: 
 derived_data/covid.csv\
	logistic_model.R

report.pdf: 
 report.Rmd\ 
 figures/Patient_Type_Age.png\
 figures/Wait_Time.png\
 derived_data/lm.txt\
 derived_data/covid.csv\
 derived_data/covid_dup.csv\
	R -e "rmarkdown::render('report.Rmd', output_format='pdf_document')"