# Coursera *R-Getting and Cleaning Data-Course project*

## Introduction

In this project, the data collected from the accelerometers from the Samsung Galaxy S smartphone
was retrieved and cleaned to prepare a tidy data that can be used for later analysis. 

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This repository contains the following files:
- `README.md` - an overview
- `CodeBook.md` - the contents of the data set.
- `run_analysis.R` - R script that was used to create the result `tidy.txt`
- `tidy.txt` - the end result of this project contains the data set.

## Creating the data set

The R script `run_analysis.R` does the following steps:
- Download, unzip and read the data set.
- Merge train and test data to create the new one (allData).
- Labels the data set.
- Extract only the data on mean and standard deviation.
- Creates a tidy dataset that consists of the average of each variable for each activity and each subject.
- Writes the data set to the `tidy.txt` file.
