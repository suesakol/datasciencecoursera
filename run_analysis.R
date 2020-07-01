
# Preamble ---------- calling libraries
# check if these packages are installed. if not, install and load them

install.packages(c("tidyverse", "magrittr"))
  
library(tidyverse); library(magrittr)






# Reading in data ---------- 

# features and activities
features <- read_delim("./UCI HAR Dataset/features.txt", delim = " ", col_names = FALSE)



# train data: xxx_dat is data, xxx_sub is subject number, and xxx_y is activity labels
training_dat <- read_table("./UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
training_sub <- read_table("./UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)
training_y <- read_table("./UCI HAR Dataset/train/y_train.txt", col_names = FALSE)


# combine training data and *add descriptive column names with set_colnames* [STEP 4]
# add_column with subject id, and activity. in addition, add "training" to the data set
training_dat <- training_dat %>% 
  magrittr::set_colnames(features$X2) %>% 
  add_column(subject = training_sub$X1, 
             activity = training_y$X1,
             data = "training",
             .before = 1)



# test data:
test_dat <- read_table("./UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
test_sub <- read_table("./UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)
test_y <- read_table("./UCI HAR Dataset/test/y_test.txt", col_names = FALSE)



# combine test data and *add descriptive column names with set_colnames* [STEP 4]
test_dat <- test_dat %>% 
  magrittr::set_colnames(features$X2) %>% 
  add_column(subject = test_sub$X1, 
             activity = test_y$X1,
             data = "test",
             .before = 1)



# *combine training and test data sets* [STEP 1]
# dat <- rbind(training_dat, test_dat)
dat <- bind_rows(training_dat, test_dat)



# remove extraneous tibbles
rm(test_sub, test_dat, test_y, training_dat, training_sub, training_y)






# Filter columns with mean and sd [STEP 2] ---------- 
dat_sum <- dat %>% 
  select(subject, activity, matches(".*-mean().*"), -matches("meanFreq"), matches(".*-std().*"))






# Add descriptive activities names [STEP 3]
dat_sum <- dat_sum %>% 
  mutate(activity_label = case_when(activity == 1 ~ "walking",
                                    activity == 2 ~ "walking_upstairs",
                                    activity == 3 ~ "walking_downstairs",
                                    activity == 4 ~ "sitting",
                                    activity == 5 ~ "standing",
                                    activity == 6 ~ "laying")
         ) %>% 
  select(subject, activity, activity_label, everything())





# Find summary statistics [STEP 5]
dat_sum2 <- dat_sum %>% 
  group_by(subject, activity_label) %>% 
  summarize_all(.funs = mean)


# Write out a tidy data set
write.table(dat_sum2, file = "tidydata.txt", row.names = FALSE)

