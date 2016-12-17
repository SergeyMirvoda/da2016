#' ---
#' author: "Zhenyok Nazedwox"
#' ---

# 01 data
data <- read.csv("../data/calif_penn_2011.csv")
nrow(data)
ncol(data)
# количество NA по каждому столбцу для каждой строки
colSums(apply(data,c(1,2), is.na))
omdata <- na.omit(data)
# сколько строк было удалено
nrow(data) - nrow(omdata)

# 02 new houses
plot(omdata$Median_house_value,
     omdata$Built_2005_or_later,
     xlab = "Median house value", ylab = "Built 2005 or later")
# California 6
plot(omdata$Median_house_value[omdata$STATEFP == 6],
     omdata$Built_2005_or_later[omdata$STATEFP == 6],
     xlab = "Median house value", ylab = "Built 2005 or later")
# Pennsylvania 42
plot(omdata$Median_house_value[omdata$STATEFP == 42],
     omdata$Built_2005_or_later[omdata$STATEFP == 42],
     xlab = "Median house value", ylab = "Built 2005 or later")

# 03 vacancy
omdata$vacancy_rate = omdata$Vacant_units / omdata$Total_units
min(omdata$vacancy_rate)
max(omdata$vacancy_rate)
mean(omdata$vacancy_rate)
median(omdata$vacancy_rate)
plot(omdata$Median_house_value,
     omdata$vacancy_rate,
     xlab = "Median house value", ylab = "Vacancy rate")
# чем больше средняя стоимость дома, тем их лучше покупают, так как доля незанятых домов меньше

# 04 correlation
# в acc записываются индексы для строк штата 6 и округа 1
# в accmv записываются значения Median house value для отобранных строк
# считается медиана по полученным значениям
acc <- c()
for (tract in 1:nrow(omdata)) {
  if (omdata$STATEFP[tract] == 6) {
    if (omdata$COUNTYFP[tract] == 1) {
      acc <- c(acc, tract)
    }
  }
}
accmv <- c()
for (tract in acc) {
  accmv <- c(accmv, omdata[tract,10])
}
fw = median(accmv)

# second way
sw = median(as.numeric(unlist(subset(omdata, STATEFP == 6 & COUNTYFP == 1, select = 10))))

# average percent of builds
# Butte County
bc = mean(as.numeric(unlist(subset(omdata, STATEFP == 6 & COUNTYFP == 7, select = c(16:24)))))
# Santa Clara
sc = mean(as.numeric(unlist(subset(omdata, STATEFP == 6 & COUNTYFP == 85, select = c(16:24)))))
# York County
yc = mean(as.numeric(unlist(subset(omdata, STATEFP == 42 & COUNTYFP == 133, select = c(16:24)))))

# cor function
# all dataset
cor(omdata[[10]], omdata[[16]])
# California
cor(omdata[which(omdata$STATEFP == 6), 10], omdata[which(omdata$STATEFP == 6), 16])
# Pennsylvania
cor(omdata[which(omdata$STATEFP == 42), 10], omdata[which(omdata$STATEFP == 42), 16])
# Butte County
bc = omdata[which(omdata$STATEFP == 6 & omdata$COUNTYFP == 7),]
cor(bc[[10]], bc[[16]])
# Santa Clara
sc = omdata[which(omdata$STATEFP == 6 & omdata$COUNTYFP == 85),]
cor(sc[[10]], sc[[16]])
# York County
yc = omdata[which(omdata$STATEFP == 42 & omdata$COUNTYFP == 133),]
cor(yc[[10]], yc[[16]])

# plots
plot(bc$Median_house_value, bc$Median_household_income,
     xlab = "Median house value",
     ylab = "Median household income")

plot(sc$Median_house_value, sc$Median_household_income,
     col = "blue",
     xlab = "Median house value",
     ylab = "Median household income")

plot(yc$Median_house_value, yc$Median_household_income,
     col = "yellow",
     xlab = "Median house value",
     ylab = "Median household income")

