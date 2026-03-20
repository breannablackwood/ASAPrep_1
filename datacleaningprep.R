#ASA Datafest Part 1 Prep 2026
#Reading in and Cleaning Data
#Breanna Blackwood & Anh Pham, UF Statistics Club

#Libraries
library(dplyr)

#Read in data files 
#I would recommend downloading it to your computer and reading it in. 
#This is easiest for me personally. 

data <- read.csv("~/Downloads/Guetschow-et-al-2022-PRIMAP-hist_v2.4_11-Oct-2022.csv")
head(data) #allows us to see the beginning rows of the data. 

#Now, let's say we want to only focus on certain columns of the data. 
#Then, we would want to create a new dataset that only has these columns. 
##Subsetting


##Getting rid of NA values 


##Transpose rows 


##Creating new variables/columns


#Write out to a CSV. 