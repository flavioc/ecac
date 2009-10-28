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

get_filename <- function (name) {
  return(paste("R", "/", name, sep = ""))
}

proportion_table <- function (data) {
  return(prop.table(table(data)) * 100.0)
}

### generates graphics
generate_histogram <- function(data, filename, title) 
{
    png(file=get_filename(filename), bg="white")
    hist(data, prob=T, xlab="", main=title)
    lines(density(data, na.rm=T))
    rug(jitter(data))
    dev.off()
}

generate_barplot <- function(data, filename, title, ymax = 12000)
{
  png(file = get_filename(filename), bg="white")
  barplot(data, xlab="", main=title, ylim = range(0, ymax))
  dev.off()
}

generate_boxplot <- function(data, filename, title) 
{
    png(file=get_filename(filename), bg="white")
    boxplot(data, boxwex=0.15, ylab=title)
    rug(jitter(data), side=2)
    abline(h=mean(data, na.rm=T), lty=2)
    dev.off()
}

generate_histogram(data$age, "histogram_age.png", "Age Distribution")
generate_histogram(data$fnlwgt, "histogram_fnlwgt.png", "FNLWGT Distribution")
generate_histogram(data$education_num, "histogram_education_num.png", "Education Num Distribution")
generate_histogram(data$capital_gain, "histogram_capital_gain.png", "Capital Gain Distribution")
generate_histogram(data$capital_loss, "histogram_capital_loss.png", "Capital Loss Distribution")
generate_histogram(data$hours_per_week, "histogram_hours_per_week.png", "Hours Per Week Distribution")

generate_barplot(table(data$workclass), "barplot_workclass.png", "Work class", ymax = 25000)
generate_barplot(table(data$education), "barplot_education.png", "Education")
generate_barplot(table(data$marital_status), "barplot_marital_status.png", "Marital status", ymax = 20000)
generate_barplot(table(data$occupation), "barplot_occupation.png", "Occupation", ymax = 5000)
generate_barplot(table(data$relationship), "barplot_relationship.png", "Relationship", ymax = 15000)
generate_barplot(table(data$sex), "barplot_sex.png", "Sex", ymax = 25000)
generate_barplot(table(data$race), "barplot_race.png", "Race", ymax = 30000)
generate_barplot(table(data$native_country), "barplot_native_country.png", "Native country (ALL)", ymax = 35000)
generate_barplot(table(data$native_country, exclude = "united_states"), "barplot_native_country_no_us.png", "Native country (No united_states)", ymax = 800)

generate_boxplot(data$age, "boxplot_age.png", "Age")
generate_boxplot(data$fnlwgt, "boxplot_fnlwgt.png", "FNLWGT")
generate_boxplot(data$education_num, "boxplot_education_num.png", "Education Num")
generate_boxplot(data$capital_gain, "boxplot_capital_gain.png", "Capital Gain")
generate_boxplot(data$capital_loss, "boxplot_capital_loss.png", "Capital Loss")
generate_boxplot(data$hours_per_week, "boxplot_hours_per_week.png", "Hours Per Week")

dbDisconnect(con)
