### loads the required libraries
library(RMySQL)

### connects and loads the table data
con <- dbConnect(dbDriver("MySQL"), dbname="adult", user="root", password="root")
data <- dbReadTable(con, "adult")

### replaces unknown with empty values for missing values processing
data[data == "unknown"] <- NA

### turns strings into factors
data$workclass      <- factor(data$workclass)
data$education      <- factor(data$education)
data$marital_status <- factor(data$marital_status)
data$occupation     <- factor(data$occupation)
data$relationship   <- factor(data$relationship)
data$race           <- factor(data$race)
data$sex            <- factor(data$sex)
data$native_country <- factor(data$native_country)
data$plus_50        <- factor(data$plus_50)

### generates graphics
generate_histogram <- function(data, filename, title) {
    png(file=filename, bg="white")
    hist(data, prob=T, xlab="", main=title)
    lines(density(data, na.rm=T))
    rug(jitter(data))
    dev.off()
}

generate_histogram(data$age, "histogram_age.png", "Age Distribution")
generate_histogram(data$fnlwgt, "histogram_fnlwgt.png", "FNLWGT Distribution")
generate_histogram(data$education_num, "histogram_education_num.png", "Education Num Distribution")
generate_histogram(data$capital_gain, "histogram_capital_gain.png", "Capital Gain Distribution")
generate_histogram(data$capital_loss, "histogram_capital_loss.png", "Capital Loss Distribution")
generate_histogram(data$hours_per_week, "histogram_hours_per_week.png", "Hours Per Week Distribution")

