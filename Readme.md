### Read Me

These are the steps that I use to prepare tidyData.txt

1. Library dplyr
2. Start loading files that we need into our data.frames  
* xtrain, ytrain, subject_train,  
* xtest, ytest, subject_test,  
* features,   
* activitiesLabel  
3. Then cliping those data together  
* rbind *xtrain* and *xtest* data to *Data1*  
* rbind two *subjects* from train and test dataset into one    
* rbind two *activity-labels* from train and test dataset into one  
* cbind subjects to *Data1*  
* cbind activitylabel to *Data1*  
4. Prepare names for our *Data1* by add *subjects* and *activities* to the last two rows of *features*
5. Then use *features* to rename all the column names in *Data1*
6. Then we will prepare a vector that contains only names that we  want  
* Extract *colNames* from *features* column2  
* Then select only names that we want using grepl  
7. Use *colNames* to subset *Data1* to select only columns that we want
8. Time to rename those activities,  
* I use mutate and str_replace_all to rename them   
* By pull the right label from *activities-labels*  
9. Step 5 time to summarise the data base on subjects and activities  
* Find mean() of the variables  
* Use group_by() then summarise_each() with mean()  
* Create new variable tidyData.  
10. Use write.table to write tidyData to tidyData.txt