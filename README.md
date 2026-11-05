# Getting and Cleaning Data Course Project

This repository contains the R script, documentation, and tidy dataset output for the Coursera *Getting and Cleaning Data* final project.

## Project Files
* `run_analysis.R`: R script that downloads the raw data, cleans it, and executes all 5 required processing steps.
* `tidy_data.txt`: The exported final tidy dataset containing the averages of all mean and standard deviation variables grouped by subject and activity.
* `CodeBook.md`: Describes the dataset variables, data sources, transformations, and cleaning steps performed.
* `README.md`: Explains how the analysis script functions.

## How to Run the Script
1. Clone this repository to your computer.
2. Open R or RStudio and set your working directory to the cloned repository location.
3. Source the script: `source("run_analysis.R")`.
4. The script will automatically download and extract the source zip file if not already present, run the data pipeline, and output `tidy_data.txt` in your working directory.