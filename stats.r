### loads the required libraries
library(RMySQL)
library(dprep)

### connects and loads the table data
con <- dbConnect(dbDriver("MySQL"), dbname="adult", user="root", password="root")
data <- dbReadTable(con, "adult")

### replaces unknown with empty values for missing values processing
data[data == "unknown"] <- NA

### turn strings into factors
data$workclass <- factor(data$workclass)
data$education <- factor(data$education)
data$marital_status <- factor(data$marital_status)
data$occupation <- factor(data$occupation)
data$relationship <- factor(data$relationship)
data$race <- factor(data$race)
data$sex <- factor(data$sex)
data$native_country <- factor(data$native_country)
data$plus_50 <- factor(data$plus_50)
