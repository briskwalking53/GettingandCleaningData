Getting and Cleaning Data Course Project

run_Analysis.r converted the original behavior data in the following steps.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set 
   with the average of each variable    for each activity and each subject.

Original Data from UCI

 'features.txt': List of all features.
 'activity_labels.txt': Links the class labels with their activity name.
 'train/X_train.txt': Training set.
 'train/y_train.txt': Training labels
 'test/X_test.txt': Test set
 'test/y_test.txt': Test labels
 
 Variables in run_Analysis.R
 
  x_train : contains training data
  y_train : contains training labels
  s_train : contains training data subjects whose row identifies the subject who 
            performed the activity for each window sample. 


  x_test : contains test data
  y_test : contains test labels
  s_test : contains test data subjects whose row identifies the subject who performed 
            the activity for each window sample. 

  features : contains all of features
  activity : contains Links the class labels with their activity name
  
  merge_x : binds x_train and x_test
  merge_y : binds y_train and y_test
  merge_s : binds s_train and s_test
  
  merge_data : binds merge_s, merge_y, merge_x in this order
  
  meas_std_data : extracts only the measurements on the mean and standard 
                  deviation for each measurement
                  
  Tidy_data : final data

