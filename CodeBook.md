Codebook for the Tidy Data Set project

This Tidy Data version of the dataset is described below.

The Variables

Subject: contains as values numbers between 1 and 30, to represent the 30 volunteers for the experiment

Activity: the activities performed by the subjects when the measurements were taken. 
These values are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

The remaining columns are all of the combinations of the different ways the measurements were taken. 
* If the variable name has "-Mean" in it, the column contains the average of those measurements.
* If the variable name has "-Std" in it, the column contains the standard deviation of those measurements.
* For each of the combinations of measurements, a set was taken by calculating variables from the time and
  frequency domain (per the original README). The column names identify these by starting with "Time-" or 
  "Freq-".
* These columns contain measurements from an experiment on 30 subjects within an age bracket of 19-48
  years. These subjects performed the activities above while wearing a smartphone with an embedded
  accelerometer and gyroscope. The sensor acceleration signal has a gravitational and body motion
  component, which are the "Body" and "Gravity" measurements. 

========
The Data

This is a subset of the Human Activity Recognition Using Smartphones Dataset, Version 1.0.
The README for this data set says 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist.

The original set had overall data sets for the subjects, their activities, and the measurements taken
for the activities. 

For each record in this Tidy Data dataset is provided
- The mean and standara deviation for
   * Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
   * Triaxial Angular velocity from the gyroscope. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.



===========================
Transformations on the Data

1. The subject lists were read in from the subject files as data frames.

test/subject_test.txt
train/subject_train.txt

These data frames had one column each, and the column was given the name "subject".

2. The original measurement set of data files were read in as data frames.

test/X_test.txt
train/X_train.txt

The file of feature names (features.txt) was read in and was used to name the columns in the data frames for the test and train measurement sets.

3. The list of activities were read in from the files.

test/y_test.txt
train/y_train.txt

The labels of the activities were read in from the activity labels file: activity_labels.txt.

The separate activities data frames were each merged with the activity labels, giving a data frame with two
columns. Each of these data frames had the original activities in the first column, and the English names of
these same activities in the second column. The data frame for holding these activities was assigned the value 
of the second column, and given the name "Activity".

4. The test data frames were combined using rbind() in the order of subject, activity, measurement data. The
train data frames were combined using cbind() in the order of subject, activity, measurement data. Then the
entire test data frame was combined with the entire train data frame, with the test data coming first, into one
data frame using rbind().

5. The resulting combined data set was cut down using grep() to contain only the subjects, activities, and all columns contining the mean() or std() of the measurements. meanFreq() was left out, because that cluttered the resultling dataset.

6. This new dataset was tidied by making the column names more clear, via gsub() commands to clean up and clarify the column names. All column names had () and - removed.
