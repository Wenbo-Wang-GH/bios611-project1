FROM rocker/verse
MAINTAINER Wenbo Wang <wenbo@live.unc.edu>
RUN echo "Hello World"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('kernlab')"
RUN R -e "install.packages('gbm')"
RUN R -e "install.packages('e1071')"
RUN R -e "install.packages('caret')"
RUN R -e "install.packages('shiny')"
RUN apt update -y && apt install -y python3-pip
RUN pip3 install jupyter jupyterlab
