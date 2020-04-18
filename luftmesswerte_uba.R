library(lubridate)
library(readr)
library(huxtable)
library(dplyr)

savepath = "C:/Users/User/Documents/R/luftmesswerte/"
a <- read_csv(paste0(savepath,"airquality_germany.csv"), locale = locale(encoding = "ISO-8859-2"))

a$corona = ifelse(a$date>='2020-03-23',1,0)
a$wd = as.factor(weekdays(a$date, abbreviate = FALSE))
a$hour = as.factor(hour(a$date))
a$night = as.factor(ifelse(a$hour %in% c(22,23,1,2,3,4,5),1,0))
a$evening = as.factor(ifelse(a$hour %in% c(15,16,17,18,19,20,21),1,0))
a$month = as.factor(month(a$date))
a$year = as.factor(year(a$date))

# Remove UBA stations (UB)
a = a[!(a$state=="UB"),]

# Declare reference levels / factors
a$state=relevel(as.factor(a$state),"BY")
a$month=relevel(a$month,"4")
a$year=relevel(a$year,"2019")
a$loc_type1=relevel(as.factor(a$loc_type1),"ländlich abgelegen")
a$loc_type1=relevel(as.factor(a$loc_type2),"ländlich")
a$neighboring=relevel(as.factor(a$neighboring),"Hintergrund")

# Pollutants
no2 = a[!is.na(a$no2),]
pm10 = a[!is.na(a$pm10),]

summary(no2$no2)
summary(pm10$pm10)

rm(a)
#######################################################################
# Breakpoint-Test

# NO2
r1a = lm(no2~month+corona+loc_type2+neighboring,data=no2)
r1b = lm(no2~month+year+corona+loc_type2+neighboring,data=no2)
r1c = lm(no2~month+year+corona*neighboring+loc_type2,data=no2)
r1d = lm(no2~month+year+neighboring+corona*loc_type2,data=no2)
r1e = lm(no2~month+year+corona*neighboring+corona*loc_type2,data=no2)

mean(no2$no2)
mean(no2$no2[no2$corona==0],na.rm = T)
mean(no2$no2[no2$corona==1],na.rm = T)

mean(no2$no2)
mean(no2$no2[no2$year==2016],na.rm = T)
mean(no2$no2[no2$year==2017],na.rm = T)
mean(no2$no2[no2$year==2018],na.rm = T)
mean(no2$no2[no2$year==2019],na.rm = T)

# PM10
r2a = lm(pm10~month+corona+loc_type2+neighboring,data=pm10)
r2b = lm(pm10~month+year+corona+loc_type2+neighboring,data=pm10)
r2c = lm(pm10~month+year+corona*neighboring+loc_type2,data=pm10)
r2d = lm(pm10~month+year+neighboring+corona*loc_type2,data=pm10)
r2e = lm(pm10~month+year+corona*neighboring+corona*loc_type2,data=pm10)
 
mean(pm10$pm10)
mean(pm10$pm10[pm10$corona==0],na.rm = T)
mean(pm10$pm10[pm10$corona==1],na.rm = T)

mean(pm10$pm10[pm10$year==2016],na.rm = T)
mean(pm10$pm10[pm10$year==2017],na.rm = T)
mean(pm10$pm10[pm10$year==2018],na.rm = T)
mean(pm10$pm10[pm10$year==2019],na.rm = T)

regs_no2 <- huxreg('(1) NO2'=r1a,'(2) NO2'=r1b,'(3) NO2'=r1c, '(4) NO2'=r1d,'(5) NO2'=r1e)
regs_no2

regs_pm10 <- huxreg('(1) PM10'=r2a,'(2) PM10'=r2b,'(3) PM10'=r2c, '(4) PM10'=r2d,'(5) PM10'=r2e)
regs_pm10

