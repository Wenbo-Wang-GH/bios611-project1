.PHONY: clean

clean: 
	rm -f derived_data/*.csv
	rm -f derived_data/*.txt 
	rm -f figures/*.png 
	rm -f figures/*.txt 
	rm -f report.pdf

derived_data/covid.csv derived_data/covid_dup.csv: source_data/covid.csv tidy_source_data.R
	Rscript tidy_source_data.R 
	
figures/Patient_Type_Age.png: derived_data/covid.csv
	Rscript patient_type_vs_age.R

figures/Wait_Time.png: derived_data/covid.csv
	Rscript wait_time.R
	
figures/Prediction_glm.png: derived_data/covid.csv
	Rscript logistic_predict_density.R
	
figures/Prediction_caret_glm.png: derived_data/covid.csv
	Rscript caret_glm.R
	
figures/lm.txt: derived_data/covid.csv
	Rscript logistic_glm.R
	
figures/bm.txt: derived_data/covid.csv
	Rscript logistic_gbm.R

report.pdf: report.Rmd figures/Patient_Type_Age.png figures/Wait_Time.png figures/Prediction_glm.png figures/Prediction_caret_glm.png figures/lm.txt figures/bm.txt derived_data/covid.csv derived_data/covid_dup.csv
	R -e "rmarkdown::render('report.Rmd', output_format='pdf_document')"

.PHONY: variables_select

variables_select: derived_data/covid.csv
	Rscript variables_select.R ${PORT}
	
	
	
	