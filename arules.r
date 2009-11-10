### loads the required libraries
library(RMySQL)
library(arules)
source('common.r')

data <- get_dataset("root")

### remove attributes that are generated from other attributes
data$fnlwgt <- NULL
data$education_num <- NULL

### remove id attribute
data$id <- NULL

### transform attributes age, hours_per_week, capital_gain e capital_loss into categories
data$age <- ordered(cut(data$age, c(15, 25, 45, 65, 100)), labels = c("young", "middle_aged", "senior", "old"))
data$hours_per_week <- ordered(cut(data$hours_per_week, c(0, 25, 40, 60, 168)), labels = c("part_time", "full_time", "over_time", "workaholic"))
data$capital_gain <- ordered(cut(data$capital_gain, c(-Inf, 0, median(data$capital_gain[data$capital_gain > 0]), Inf)), labels = c("none", "low", "high"))
data$capital_loss <- ordered(cut(data$capital_loss, c(-Inf, 0, median(data$capital_loss[data$capital_loss > 0]), Inf)), labels = c("none", "low", "high"))

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

### coerce data to transactions class
dataT <- as(data, "transactions")

### output item frequency plot
set_png_output("item_frequency.png")
itemFrequencyPlot(dataT,support=0.1,cex.names=0.8)
dev.off()

### search for apriori rules
### support = 2%
### confidence = 60%
rules <- apriori(dataT, parameter=list(support = 0.02, confidence=0.6))

### get a subset of rules involving plus_50 on the right side
rulesIncomeSmall <- subset(rules, subset = rhs %in% "plus_50=0" & lift > 1.2)
rulesIncomeSmall <- SORT(rulesIncomeSmall, by = "confidence")
rulesIncomeLarge <- subset(rules, subset = rhs %in% "plus_50=1" & lift > 1.2)
rulesIncomeLarge <- SORT(rulesIncomeLarge, by = "confidence")

### save results
WRITE(rulesIncomeSmall, file = "R/arules_small.csv", sep = ",", col.names = NA)
WRITE(rulesIncomeLarge, file = "R/arules_large.csv", sep = ",", col.names = NA)