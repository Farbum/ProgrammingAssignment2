## setting working directory
setwd("C://Users/Had/Datadirectory/UCI HAR Dataset/")

## Loading appropriate libraries
library(plyr)

## STEP 1 ##

##Loading training datasets and renaming variables
features<-read.table("./features.txt")
lab_position<-read.table("./train/y_train.txt")
subjects<-read.table("train/subject_train.txt")
training_data<-read.table("train/X_train.txt")

subjects<-rename(subjects,c("V1"="num_subject"))
lab_position<-rename(lab_position,c("V1"="activity"))
features<-rename(features,c("V2"="name_var","V1"="num_var"))
colnames(training_data)<-features$name_var

##merging training datasets
training_data<-cbind(subjects,lab_position,training_data)
training_data<-mutate(training_data,group="training")

##Loading test datasets and renaming variables
lab_position<-read.table("./test/y_test.txt")
subjects<-read.table("test/subject_test.txt")
test_data<-read.table("test/X_test.txt")

subjects<-rename(subjects,c("V1"="num_subject"))
lab_position<-rename(lab_position,c("V1"="activity"))
colnames(test_data)<-features$name_var

##merging test datasets
test_data<-cbind(subjects,lab_position,test_data)
test_data<-mutate(test_data,group="test")

##merging test and training datasets
all_data<-rbind(training_data,test_data)

## STEP 2 ##

##extracting mean and std variables
all_data<-cbind(all_data[,1:2],all_data$group,all_data[,grepl("[Mm]ean\\(\\)|std\\(\\)",colnames(all_data))])
colnames(all_data)[3]<-"group"


## STEP 3 ##

## setting activity names
activities<-read.table("./activity_labels.txt")
for (i in 1:length(all_data$activity)) {
        z<-as.numeric(all_data[i,2])
        all_data[i,2]<-as.character(activities$V2[z])
}


## STEP 4 ##

## labelling the dataset already done

## STEP 5 ##

##creating a matrix with the average of each variable for each subject and each activity
s<-split(all_data,list(all_data$activity,all_data$num_subject))
average_data<-sapply(s,function(x) colMeans(x[,4:69]))

