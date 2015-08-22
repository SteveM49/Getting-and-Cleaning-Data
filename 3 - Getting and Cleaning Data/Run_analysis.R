#############################################################
# run_analysis.R
#
# Assignment for month 3 of data analysis MOOC
#      Getting and Cleaning Data
# 1 Merge the training and the test sets to create one data set.
# 2 Extract only the measurements on the mean and standard deviation for each measurement. 
# 3 Use descriptive activity names to name the activities in the data set
# 4 Appropriately label the data set with descriptive variable names. 
# 5 From the data set in step 4, create a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
#
#############################################################

# Step 1
setwd("F:/Users/Athena/My Documents/DataAnalysis Coursea/3 - Getting and Cleaning Data/UCI HAR Dataset")
y_test <- read.table("./test/y_test.txt", quote="\"", comment.char="")
y_train <- read.table("./train/y_train.txt", quote="\"", comment.char="")
y <- rbind(y_test,y_train)

subject_test <- read.table("./test/subject_test.txt", quote="\"", comment.char="")
subject_train <- read.table("./train/subject_train.txt", quote="\"", comment.char="")
subject <- rbind(subject_test,subject_train)

X_test <- read.table("./test/X_test.txt", quote="\"", comment.char="")
X_train <- read.table("./train/X_train.txt", quote="\"", comment.char="")
X <- rbind(X_test,X_train)

features <- read.table("./features.txt", quote="\"", comment.char="")
names(X) <- features[,2]
rm (y_test,y_train,subject_train,subject_test,X_test,X_train)

library(dplyr)
C1 <- cbind(subject,y) 
Complete <- cbind(C1,X)
names(Complete)[1] <- "Subject"
names(Complete)[2] <- "ActivityFactor"
xtabs(~ActivityFactor+Subject, Complete)

#check for na
sum(is.na(Complete))

#Step 2
# Select the mean() and std() variables
gl <- grepl('mean()',names(Complete)) | grepl('std()',names(Complete))
gl[1:2] <- TRUE
Selected <- Complete[,gl]

#Step 4 Good column names
library(stringr)
adjustName <- function(string){
        string <- str_replace(string,"Body","")
        string <- str_replace(string,"Acc","Accel")
        string <- str_replace(string,"GravityAcc","Grav")
        string <- str_replace(string,"-mean\\(\\)-","Mu")
        string <- str_replace(string,"-std\\(\\)-","Sigma")
        string <- str_replace(string,"-meanFreq\\(\\)-","MeanFreq")
        string <- str_replace(string,"-mean\\(\\)$","Mu")
        string <- str_replace(string,"-std\\(\\)$","Sigma")
        string <- str_replace(string,"-meanFreq\\(\\)$","MeanFreq")
        string <- str_replace(string,"^t","time")
        string <- str_replace(string,"^f","freq")
        string
}
#write.table(names(Selected), "colNames.csv", sep="\t", row.names=FALSE, col.names=FALSE)
revisedNames <- lapply(names(Selected),adjustName)
# Edit in Excel then save as "colNamesEdited.csv" in wd
#revisedNames <- read.table("colNamesEdited.csv", sep=",", header=TRUE)
names(Selected) <- revisedNames

#Step 5 get means for each variable, subject, and activity
install.packages("reshape2")
library(reshape2)
SelectMelt <- melt(Selected,id.vars=1:2)
head(SelectMelt)
colnames(SelectMelt)[2] <- "ActivityFactor"
colnames(SelectMelt)[1] <- "Subject"
SelectMeans <- dcast(SelectMelt,Subject+ActivityFactor ~ variable,mean)

# Step 3 done here with the penultimate ds
# add column with Activiy as descriptive
Labl <- c("Walk","WalkUp","WalkDown","Sit","Stand","Lay")
labelDF <- data.frame("ActivityFactor"=1:6,"Activity"=Labl)
FinalMeans <- left_join(labelDF,SelectMeans)
# Drop the column ActivityFactor
FinalMeans <- FinalMeans[,-1]

#Step Omega: write the file
write.table(FinalMeans, "FinalMeans.txt")
write.table(revisedNames, "RevisedNames.txt")
