Tidy-Data-Set
=============
For this assignment we are generating a mean for each combination of subject, activity, and measurement.

Full description of original data set: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Original data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

run_analysis.R:
  1. Reads in the data from the originial data set.
  2. Merges the training and the test sets to create one data set.
  3. Cuts down the merged data set to only include mean() and std() columns from the measurement columns.
  4. Tidies up the resulting data set.
  
CodeBook.md:
  Contains information about the variables, the data, and the transformations done on the data.
  
TidyData.csv:
   The resulting tidy data set.
  

Choices for the final tidy data set:

The goal for this data set was a mean and std for each combination of subject, activity, and measurement. This
final set contains this information, in a form that should be easy to read and understand. Choices I made:

* Each set of combinations had an x, y, and z version. I could have moved this into a "tall" version of the
dataset, with an extra column for whether this was x, y, or z, and combining the x, y, and z columns into one
long column. That would cut down the number of columns by about two-thirds, but I'm not convinced it would make
the data set any easier to use, especially since there is no clear indication of what the next use of this tidy
set will be.

* I disagree with the definition of a tidy data set that insists that variable names be all lower case. I 
did not change these, but tried to clarify what was going on.