# Use the rocker/r-ver base image
FROM rocker/r-ver:4.1.0

# Install R packages
RUN R -e 'install.packages(c("readr", "dplyr", "purrr", "janitor", "nanoparquet"), repos = "https://cloud.r-project.org")'

# Set working directory
WORKDIR /app

# Copy the R script to the container
COPY download_files.R /app/download_files.R

# Command to run the R script
CMD ["Rscript", "download_files.R"]
