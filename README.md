# Getting and Cleaning Data -- Project

This script is written to process the following files in the UCI HAR dataset:

1. 'features.txt': List of all features from original data set; provide information about column names
2. 'X_train.txt': Training set which includes measurement collected from participants
3. 'y_train.txt': Training labels (from 1 to 6)
4. 'X_test.txt': Test set which includes measurement collected from participants at test
5. 'y_test.txt': Test labels (from 1 to 6)
6. 'subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
7. 'subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


The script does the following things

1. Read into R data. 

2. Begin with feature.txt which will be used as column names in the training and test sets
2.1 Load training data sets into R with read_table() from the 'tidyverse' packages. They consist of measurement (training_dat), subject IDs (training_sub) and activity labels (training_y)
2.2 Then, add column names from features to the training data. Then, subject IDs and activity columns are added to the training data. Finally, these columns are moved to the front of the dataframe.

3. Similar steps are taken to create a test data set.

4. The two data sets are combined together.

5. In order to extract the columns that contain an average (i.e., having mean() in the column names) and standard deviation (i.e., with std() in column names), 'select' function from tidyverse is used along with matches() which enables us to provide a regex to get mean and standard deviation columns. Note that with matches() columns with meanFreq() is included, and thus we remove those out with -matches("meanFreq()")

6. Add activity labels to the data set with mutate() and case_when(). These activities can be found in activity_labels.txt 

7. To calculate descriptive stats, we use group_by() and specify the grouping we want (subject and activity). Then write out a dataframe.
