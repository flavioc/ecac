### loads the required libraries
library(RMySQL)
library(car)
source('common.r')

data <- get_dataset("root")

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

### data without values from the us
data_no_us          <- data[data$native_country != "united_states",]

proportion_table <- function (data, exclude = NULL)
{
  return(prop.table(table(data, exclude = exclude)) * 100.0)
}

### generates graphics
generate_histogram <- function(data, filename, title) 
{
  set_png_output(filename)
  hist(data, prob=T, xlab="", main=title)
  lines(density(data, na.rm=T))
  rug(jitter(data))
  dev.off()
}

generate_barplot <- function(data, filename, title, ymax = 12000)
{
  set_png_output(filename)
  old.las <- par("las")
  old.mar <- par("mar")
  par(las = 2, mar = c(10, 4, 4, 2) + 0.1)
  barplot(data, xlab="", main=title, ylim = range(0, ymax))
  par(las = old.las, mar = old.mar)
  dev.off()
}

generate_boxplot <- function(data, filename, title) 
{
  set_png_output(filename)
  boxplot(data, boxwex=0.15, main=title)
  rug(jitter(data), side=2)
  abline(h=mean(data, na.rm=T), lty=2)
  dev.off()
}

generate_plot <- function (data1, data2, filename, title, xlab = NULL, ylab = NULL, labeldist = 5)
{
  set_png_output(filename)
  old.las <- par("las")
  old.mar <- par("mar")
  old.mgp <- par("mgp")
  par(las = 2, mar = c(10, 4, 4, 2) + 0.1, mgp = old.mgp + c(labeldist, 0, 0))
  plot(data1, data2, main = title, xlab = xlab, ylab = ylab, cex.lab = 2.0)
  par(las = old.las, mar = old.mar, mgp = old.mgp)
  dev.off()
}

generate_scatterplot <- function (data1, data2, filename, title, xlab = NULL, ylab = NULL)
{
  set_png_output(filename)
  scatterplot(data1, data2, main = title, xlab = xlab, ylab = ylab)
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

generate_barplot(proportion_table(data$workclass), "barplot_workclass_prop.png", "Workclass", ymax = 100)
generate_barplot(proportion_table(data$education), "barplot_education_prop.png", "Education", ymax = 100)
generate_barplot(proportion_table(data$marital_status), "barplot_marital_status_prop.png", "Marital status", ymax = 100)
generate_barplot(proportion_table(data$occupation), "barplot_occupation_prop.png", "Occupation", ymax = 100)
generate_barplot(proportion_table(data$relationship), "barplot_relationship_prop.png", "Relationship", ymax = 100)
generate_barplot(proportion_table(data$sex), "barplot_sex_prop.png", "Sex", ymax = 100)
generate_barplot(proportion_table(data$race), "barplot_race_prop.png", "Race", ymax = 100)
generate_barplot(proportion_table(data$native_country), "barplot_native_country_prop.png", "Native country (ALL)", ymax = 100)
generate_barplot(proportion_table(data$native_country, exclude = "united_states"), "barplot_native_country_no_us_prop.png", "Native country (No united_states)", ymax = 100)

generate_boxplot(data$age, "boxplot_age.png", "Age")
generate_boxplot(data$fnlwgt, "boxplot_fnlwgt.png", "FNLWGT")
generate_boxplot(data$education_num, "boxplot_education_num.png", "Education Num")
generate_boxplot(data$capital_gain, "boxplot_capital_gain.png", "Capital Gain")
generate_boxplot(data$capital_loss, "boxplot_capital_loss.png", "Capital Loss")
generate_boxplot(data$hours_per_week, "boxplot_hours_per_week.png", "Hours Per Week")

generate_plot(data$capital_gain, data$age, "plot_capital_gain_age.png", "Capital gain and age", xlab = "Capital gain", ylab = "Age", labeldist = 2)
generate_plot(data$capital_loss, data$age, "plot_capital_loss_age.png", "Capital loss and age", xlab = "Capital loss", ylab = "Age", labeldist = 2)
generate_plot(data$capital_gain - data$capital_loss, data$age, "plot_capital_result_age.png", "Capital result and age", xlab = "Capital result", ylab = "Age", labeldist = 2)
generate_scatterplot(data$plus_50, data$age, "plot_plus_50_age.png", "Plus 50K and age", xlab = "> 50K", ylab = "Age")

generate_scatterplot(data$hours_per_week, data$capital_gain, "plot_hpw_capital_gain.png", "Hours per week and capital gain", xlab = "Hours per week", ylab = "Capital gain")
generate_scatterplot(data$hours_per_week, data$capital_loss, "plot_hpw_capital_loss.png", "Hours per week and capital loss", xlab = "Hours per week", ylab = "Capital loss")
generate_scatterplot(data$hours_per_week, data$capital_gain - data$capital_loss, "plot_hpw_capital_result.png", "Hours per week and capital result", xlab = "Hours per week", ylab = "Capital result")
generate_scatterplot(data$plus_50, data$hours_per_week, "plot_plus_50_hpw.png", "Plus 50 and hours per week", xlab = ">50K", ylab = "Hours per week")

generate_plot(data$occupation, data$plus_50, "plot_occupation_plus_50.png", "Occupation and plus 50K", xlab = "Occupation", ylab = ">50K", labeldist = 6)
generate_plot(data$workclass, data$plus_50, "plot_workclass_plus_50.png", "Workclass and plus 50K", xlab = "Workclass", ylab = ">50K", labeldist = 4)
generate_plot(data$education, data$plus_50, "plot_education_plus_50.png", "Education and plus 50K", xlab = "Education", ylab = ">50K", labeldist = 4)
generate_plot(data$marital_status, data$plus_50, "plot_marital_status_plus_50.png", "Marital status and plus 50K", xlab = "Marital status", ylab = ">50K")
generate_plot(data$relationship, data$plus_50, "plot_relationship_plus_50.png", "Relationship and plus 50K", xlab = "Relationship", ylab = ">50K")
generate_plot(data$race, data$plus_50, "plot_race_plus_50.png", "Race and plus 50K", xlab = "Race", ylab = ">50K", labeldist = 3)
generate_plot(data$sex, data$plus_50, "plot_sex_plus_50.png", "Sex and plus 50K", xlab = "Sex", ylab = ">50K", labeldist = 3)
generate_plot(data$native_country, data$plus_50, "plot_native_country_plus_50.png", "Native country and plus 50K", xlab = "Native country", ylab = ">50K", )
generate_plot(data_no_us$native_country, data_no_us$plus_50, "plot_native_country_plus_50_no_us.png", "Native country and plus 50K (No united_states)", xlab = "Native country", ylab = ">50K")

generate_plot(data$education_num, data$capital_gain, "plot_education_num_capital_gain.png", "Education and capital gain", xlab = "Education", ylab = "Capital gain", labeldist = 0)
generate_plot(data$education_num, data$capital_loss, "plot_education_num_capital_loss.png", "Education and capital loss", xlab = "Education", ylab = "Capital loss", labeldist = 0)
generate_plot(data$education_num, data$capital_gain - data$capital_loss, "plot_education_num_capital_result.png", "Education and capital result", xlab = "Education", ylab = "Capital result", labeldist = 0)
generate_plot(data$plus_50, data$education_num, "plot_plus_50_education_num.png", "Plus 50K and education", xlab = ">50K", ylab = "Education", labeldist = 0)
