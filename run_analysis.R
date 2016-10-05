## read data in
xtrain <- read.table("./train/x_train.txt")
ytrain <- read.table("./train/y_train.txt")
subtrain <- read.table("./train/subject_train.txt")

xtest <- read.table("./test/x_test.txt")
ytest <- read.table("./test/y_test.txt")
subtest <- read.table("./test/subject_test.txt")
features <- read.table("features.txt")

colnames(xtest) <- c(as.character(features[,2]))
colnames(xtrain) <- c(as.character(features[,2]))


colnames(ytrain) <- c("class labels","activity name")
colnames(ytest) <- c("class labels","activity name")

colnames(subtest) <- "subject"
colnames(subtrain) <- "subject"
actlabel <- read.table("activity_labels.txt")

## 3 add activity name here in advance
ytest$'activity name' <- ordered(ytest$V1,
                       levels = actlabel[,1],
                       labels = actlabel[,2])

ytrain$'activity name' <- ordered(ytrain$V1,
                        levels = actlabel[,1],
                        labels = actlabel[,2])

## 1 again 
test <- cbind(xtest,ytest,subtest)
train <- cbind(xtrain,ytrain,subtrain)

comb <- rbind(train,test)

## 2
t1 = comb[,grepl("^[^_]+mean+[()]|std",names(comb))]
t1 = cbind(comb[,562:564],t1)
## 4


new <- t1
new5 <- aggregate(t1[,4:69],list(t1$`activity name`,t1$subject),mean)

## output created
write.table(new5,"output.txt",row.names = FALSE)


