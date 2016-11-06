 I. Study design

1. Download and Unzip the dataset
2. Merges the training and the test sets to one dataset (using rbind function)
	activitydata  <- rbind(activityTest, activityTrain)
	subjectdata  <- rbind(subjectTest, subjectTrain)
	featuredataall  <- rbind(featureTest, featureTrain)

3. Extracts only the measurements on the mean and standard deviation
	select variable index, which contains the letter "mean" or "std"
	select variable names, which contains the letter "mean" or "std"
	replace "mean" to "Mean"; "std" to "Std"
	remove "()" charactor in variable names

	select the variable in the data to satisfy the condition, into featuredata

4. Merges all Data
	alldata <- cbind(subjectdata, activitydata, featuredata)

5. Create tidy dataset with the average of each variable for each activity and each subject
	turn activities & subjects into factors
	Create tidy data using melt function and dcast function in "reshap2" package


II. CodeBook

	activitidata merges y_test and y_train in one dataset
	subjectdata merges subject_test and subject_train in one dataset
	featuredataall merges x_test and x_train in one dataset

	featureName: features.txt
	featureWanted.index: variable index, which contains the letter "mean" or "std"
	featureWanted.names: variable names, which contains the letter "mean" or "std"

	featuredata: only the measurements on the mean and standard deviation for each measurement

	alldata: merges activitidata and subjectdata in one dataset

	alldata.mean: contains the relevant averages
