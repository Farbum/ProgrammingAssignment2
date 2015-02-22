## How the script works :

1) It sets the working directory and loads the plyr library

2) It loads the training datasets and rename the variables in a explicit way according to the features.txt file

3) It merges the training datasets into one data frame called training_data

4) It loads the test datasets and rename the variables in a explicit way according to the features.txt file

5) It merges the test datasets into one data frame called test_data

6) It merges test_data and training_data into one tidy data called all_data

7) It extracts mean and std variables from all_data

8) It sets the explicit name for the activity numbers in all_data

9) It creates a matrix with the average of each variable for each subject and each activity called average_data