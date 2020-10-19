FROM rocker/verse
MAINTAINER Wenbo Wang <wenbo@live.unc.edu>
RUN echo "Hello World"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('kernlab')"
RUN R -e "install.packages('gbm')"
RUN R -e "install.packages('e1071')"
RUN R -e "library(devtools)"
RUN R -e "devtools::install_url('https://cran.r-project.org/src/contrib/caret_6.0-78.tar.gz')"



