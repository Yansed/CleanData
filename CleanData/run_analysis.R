
##Step 1

#read tables
xtest<-read.table("./X_test.txt")
ytest<-read.table("./y_test.txt")
xtrain<-read.table("./X_train.txt")
ytrain<-read.table("./y_train.txt")
subjecttest<-read.table("./subject_test.txt")
subjecttrain<-read.table("./subject_train.txt")
features<-read.table("./features.txt")

#change second column of features table from factor to character
features[,2]<-as.character(features[,2])
#add one more row to features table as "Activity"
a<-nrow(features)+1
b<-c(a,"Activity")
features<-rbind(features,b)

#create mydata, starting from test data
mydata<-cbind(xtest,ytest)
#adding column names from revised features table
colnames(mydata)<-features[,2]
#getting train data
mydata1<-cbind(xtrain,ytrain)
colnames(mydata1)<-features[,2]
#adding train data to mydata
mydata<-rbind(mydata,mydata1)
#adding subject column to mydata
subject<-rbind(subjecttest,subjecttrain)
colnames(subject)<-"Subject"
mydata<-cbind(mydata,subject)

##Step2

#adding one more row (Subject) to features table. This is already added in mydata, but not in features table.
a1<-nrow(features)+1
b1<-c(a1,"Subject")
features<-rbind(features,b1)
#grep mean and std
c1<-grep("mean",features[,2])
c2<-grep("std",features[,2])
d<-c(c1,c2,562,563)
# d is the sorted integer vector of all names including either mean or std
d<-sort(d)
#create new data set with only selected columns
mydata<-mydata[,d]

##Step 3

#replace activity column with labels
mydata$Activity[mydata$Activity == "1"] <- "WALKING"
mydata$Activity[mydata$Activity == "2"] <- "WALKING_UPSTAIRS"
mydata$Activity[mydata$Activity == "3"] <- "WALKING_DOWNSTAIRS"
mydata$Activity[mydata$Activity == "4"] <- "SITTING"
mydata$Activity[mydata$Activity == "5"] <- "STANDING"
mydata$Activity[mydata$Activity == "6"] <- "LAYING"

##Step 4
#column names are already added in step 1

##Step 5
#use plyr and reshape2 package to aggregate the mean per activity per subject, total 180 values
library(plyr)
library(reshape2)
melted<-melt(mydata,id.vars=c("Activity","Subject"))
summary<-ddply(melted,c("Activity","Subject"),summarise,mean=mean(value))

##write to table
write.table(summary,file="./result.txt",col.names=FALSE)

