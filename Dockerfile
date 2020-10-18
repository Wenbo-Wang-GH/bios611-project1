FROM rocker/verse
MAINTAINER Wenbo Wang <wenbo@live.unc.edu>
RUN echo "Hello World"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('kernlab')"
RUN R -e "install.packages('gbm')"
