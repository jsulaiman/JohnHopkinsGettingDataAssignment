# Author: Johan Sulaiman

# 1) a tidy data set as described below
# 2) a link to a Github repository with your script for performing the analysis
# 3) a code book that describes the variables, the data, and any transformations or work that you performed 
# to clean up the data called CodeBook.md

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


  setwd("C:/Users/lindec25/Johan/Study/Coursera/R/Getting and Cleansing Data")
  message("Reading Training and Testing data")
  Xtrain=read.table("train/X_train.txt",sep="",header=FALSE)
  Xtest=read.table("test/X_test.txt",sep="",header=FALSE)
  Ytrain=read.table("train/y_train.txt",sep="",header=FALSE)
  Ytest=read.table("test/y_test.txt",sep="",header=FALSE)
  SubjectTrain=read.table("train/subject_train.txt",sep="",header=FALSE)
  SubjectTest=read.table("test/subject_test.txt",sep="",header=FALSE)

  message("Reading features and assign descriptive activity names")
  features = read.table("features.txt",sep="",header=FALSE)
  names(Xtrain)=features[,2]
  names(Xtest)=features[,2]
  names(Ytrain)="Class_Label"
  names(Ytest)="Class_Label"
  names(SubjectTrain)="SubjectID"
  names(SubjectTest)="SubjectID"
  
  message("Merging Training and Test data")
  XData = rbind(Xtrain,Xtest)
  YData = rbind(Ytrain,Ytest)
  SData = rbind(SubjectTrain,SubjectTest)
  FullData = cbind(XData,YData,SData)
  
  message("Extract just the Mean, Standard Deviation, Class Label, SubjectID columns")
  matchingCols = grep("mean|std|Class_|Subject", names(FullData))
  SubFullData = FullData[,matchingCols]
  
  message("Match Activity Names by Class Label")
  ActivityNames = read.table("activity_labels.txt",sep="",header=FALSE)
  names(ActivityNames)=c("Class_Label","ClassName")
  FinalData = merge(x=SubFullData,y=ActivityNames,by.x="Class_Label",by.y="Class_Label")
  
  message("Write tidy data")
  write.csv(FinalData,file="tidy.txt",row.names = FALSE)