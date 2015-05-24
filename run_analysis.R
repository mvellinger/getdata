#require/install PLYR & reshape2 packages.
if(!require(plyr)) {
        install.packages("plyr")
        library(plyr)
    }

if(!require(reshape2)) {
            install.packages("reshape2")
            library(reshape2)
        }

#get the labels first
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
featureLabels <- read.table("UCI HAR Dataset/features.txt")

#get the test and train measurements
testData <- read.table("UCI HAR Dataset/test/X_test.txt")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")

#get the test and train activities
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")

#get our subject IDs for both the test and train groups
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")


#label the columns on both testData and trainData using the values names found
#in our in column 2 of our featureLabels dataframe.

colnames(testData) <- as.vector(featureLabels[,2])
colnames(trainData) <- as.vector(featureLabels[,2])


#join trainActivies and testActivities with the activityLabels to get an
#a column in each that has the human readable activity name

testActivities <- join(testActivities, activityLabels, by="V1")
trainActivities <- join(trainActivities, activityLabels, by="V1")

#name the columns for both activity lists
colnames(testActivities) <-c("activityID", "activityName")
colnames(trainActivities) <-c("activityID", "activityName")


#Name our subject ID colum and cbind it to the activities dataframe
colnames(testSubjects) <- "subjectID"
colnames(trainSubjects) <- "subjectID"

testActivities <- cbind(testActivities, testSubjects)
trainActivities <- cbind(trainActivities, trainSubjects)

#We will use the grep() function to look for values in our column names
#that contain either (using the "|" operator) "mean()" or "std()" as those
#are the values we are after. We will use this information to subset our
#dataframe, retaining only the matching columns.
#the double backslashes in the regular expression we are using to match
#the column names are required to escape the () characters.

subsetTestData<- testData[,grep("mean\\(\\)|std\\(\\)", colnames(testData))]
subsetTrainData<- trainData[,grep("mean\\(\\)|std\\(\\)", colnames(trainData))]

#we now cbind our refined measurement data to our activities and subjectID
#frames, and finally use rbind to merge the two sets of rows together.
 data1 <- cbind(testActivities, subsetTestData)
 data2 <- cbind(trainActivities, subsetTrainData)
 data <- rbind(data1, data2)

#cleanup; we remove our intermediate dataframes for the sake of our RAM.
 rm(activityLabels, featureLabels, testData, trainData,
     testActivities, trainActivities, testSubjects, trainSubjects,
     data1, data2, subsetTestData, subsetTrainData)

#in order to generate the tidy dataset, containing the mean values of the
#measurements, grouped by subject and activity, we will employ the reshape2
#package's melt() and dcast() functions to rearrange our data.

#First, let's grab the column names of our id factors and our measurements
#(subjectID and activityName will be our identifiers in this instance)
ids <- c(colnames(data[1:3]))
vars <- c(colnames(data[4:69]))

#next, we melt() the dataframe into the long format

dataMelt <- melt(data, id=ids, measure.vars=vars)

#now we restructure by subjectID and activityName, and get the mean of the
#measurements.

recast <- dcast(dataMelt, subjectID + activityName ~ variable, mean)

#to make sure there can be no mistakes, we will append "AVG" to each of our
#measurement columns to indicate that this is a mean value.

oldColumnNames <- c(colnames(recast))

fix <- c("subjectID", "activityName")
for (i in seq(oldColumnNames)) {
     if (i < 3) {
         next
    }
    else {
         fix <- c(fix, paste(oldColumnNames[i], "AVG"))
     }
 }

 #finally, we write the file:

 write.table(recast, "tidy.txt" )
