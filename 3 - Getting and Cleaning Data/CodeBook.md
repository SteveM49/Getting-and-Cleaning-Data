#Code Book for the Run_analysis.R program
## Intial Structure
The structure described in features_info had breakdowns of the following numeric categories:
1.BodyAcc
2.GravityAcc
3.BodyAccJerk
4.BodyGyro
5.BodyGyroJerk
They were presented as values in each of the X, Y, and Z direction and the magnitude of the resulting 3-vector was also captured. The twenty resulting values were measured in the time dimension whenever a subject repeated an activity.  A Fourier Transform was taken at each of the values at the times covered. Means were taken of the values and associated with the prefix 't'.  The inverse transformaion gave the frequencies associated with the time series.  These fresults are associated with the prefix 'f'.
For some unknown to me reason, not all the frequencies are given.  The body gyro jerk variables in the X, Y, and Z directions were dropped as well as the gravity acceleration. For the magnitude of the combined motion vector (Mag) the body gyro jerk was restored.
Each of the 17 measures was then subject to the following calculations:
1. mean
2. std
3. mad
4. max
5. min
6. sma
7. nergy
8. iqr
9. entropy
10. arCoeff
11. correlation
12. maxInds
13. meanFreq
14. skewness
15. kurtosis
16. bands of energy
17. angle berween a pair of vectors
Since we were only interested in the mean and std measures, I did not investigate the other measures.
##Revised structure
I changed the following segments as shown:
1. BodyAcc|Accel
2. GravityAcc|Grav
3. BodyAccJerk|AccelJerk
4. BodyGyro|Gyro
5. BodyGyroJerk|GyroJerk
6. t prefix|time prefix
7. f prefix|freq prefix

I limited the analysis to the those variables with the following calculations:
1. mean()|Mu
2. std()|Sigma
There were a number of unexpected freq values that I maintained:
------------------------
|fBodyAcc-meanFreq()-X|freqAccelMeanFreq-X|
|fBodyAcc-meanFreq()-Y|freqAccelMeanFreq-Y|
|fBodyAcc-meanFreq()-Z|freqAccelMeanFreq-Z|
|fBodyAccJerk-meanFreq()-X|freqAccelJerkMeanFreq-X|
|fBodyAccJerk-meanFreq()-Y|freqAccelJerkMeanFreq-Y|
|fBodyAccJerk-meanFreq()-Z|freqAccelJerkMeanFreq-Z|
|fBodyGyro-meanFreq()-X|freqGyroMeanFreq-X|
|fBodyGyro-meanFreq()-Y|freqGyroMeanFreq-Y|
|fBodyGyro-meanFreq()-Z|freqGyroMeanFreq-Z|
|fBodyBodyGyroMag-meanFreq()|freqGyroMagMeanFreq|
|fBodyBodyGyroJerkMag-meanFreq()|freqGyroJerkMeanFreq|
----------------------------------