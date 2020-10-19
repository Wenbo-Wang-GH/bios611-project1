FROM rocker/verse
MAINTAINER Wenbo Wang <wenbo@live.unc.edu>
RUN echo "Hello World"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('kernlab')"
RUN R -e "install.packages('gbm')"
RUN R -e "install.packages('e1071')"
RUN R -e "install.packages('caret', repos = 'http://cran.r-project.org', dependencies = c('Depends', 'Imports', 'Suggests'))"



