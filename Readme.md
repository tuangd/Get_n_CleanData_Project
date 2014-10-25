##Name: Readme.md
##By: Tuang Dheandhanoo

1. library dplyr
2. start loading files that we need into our data.frames  
        * xtrain, ytrain, subject_train,  
        * xtest, ytest, subject_test,  
        * features,   
        * activitiesLabel  
3. then cliping those data together  
        * rbind xtrain and xtest data to Data1  
        * rbind two subject from train and test data into one    
        * rbind two activity labels from train and test data into one  
        * cbind subjects to Data1  
        * cbind activitylabel to Data1  
4. prepare names for our Data1 by add subjects and activities to the last two rows of 'features'
5. then use features to rename all the column names in Data1
6. then we will prepare a vector that contains only names that we  want
        * extract colNames from features column2  
        * then select only names that we want using grepl  
7. use colNames to subset Data1 to select only columns that we want
8. time to rename those activities,  
        * I use mutate and str_replace_all to rename them   
        * by pull the right label from activitiesLabel  
9. step 5 time to summarise the data base on subjects and activities  
        * and find mean() of the variables  
        * use group_by() then summarise_each() with mean()  
        * save them to tidyData  
10. then write that tidyData to file.