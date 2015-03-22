# GCDProject
Getting and Cleaning Data Project
This repository contains the necessary files for course assignment
Files list:
1. Code book.Md
2. run_analysis.R
3. This file itself 

It is assumeed that the Samsung data is downloaded and extracted into current working directory. If not code included in the R script has to be separately run to download and unzip the data into working directory.
Required libraries- plyr

Run "run_analysis.R" to create:
"Tidy_data.txt" a combined data containing both test and training subjects with means of measurements. 
please use "write.table(Tidy_data, "Tidy_data.txt", row.names = F)" command to read the "Tidy_data" back into R.
