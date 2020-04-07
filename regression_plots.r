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
a$month=relevel(a$month,"2")
a$year=relevel(a$year,"2020")
a$loc_type1=relevel(as.factor(a$loc_type1),"städtisches Gebiet")
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
r1a = lm(no2~year+corona,data=no2)
r1b = lm(no2~month+year+corona,data=no2)
r1c = lm(no2~month+year+corona+loc_type1+neighboring,data=no2)

mean(no2$no2)
mean(no2$no2[no2$corona==0],na.rm = T)
mean(no2$no2[no2$corona==1],na.rm = T)

# PM10
r2a = lm(pm10~year+corona,data=pm10)
r2b = lm(pm10~month+year+corona,data=pm10)
r2c = lm(pm10~month+year+corona+loc_type1+neighboring,data=pm10)
 
mean(pm10$pm10)
mean(pm10$pm10[pm10$corona==0],na.rm = T)
mean(pm10$pm10[pm10$corona==1],na.rm = T)

regs <- huxreg('(1) NO2'=r1a,'(2) NO2'=r1b,'(3) NO2'=r1c, '(4) PM10'=r2a,'(5) PM10'=r2b,'(6) PM10'=r2c)
regs

#######################################################################
# Plots: long timeseries

library(ggplot2)
# no2
png(filename=paste0(savepath, sys.date(),"_no2_long.png"), width = 800, height = 600)
ggplot(no2, aes(x = date, y = no2, colour = state)) + #geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 20),se = t) + theme_bw() +
  #geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-16"))), linetype=4, colour="black") +
  geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-23"))), linetype=4, colour="black") +
  xlab("date") +
  ylab("no2") +
  ggtitle("no2 by german states (bundesländer)")
dev.off()

# pm10
png(filename=paste0(savepath, sys.date(),"_pm10_long.png"), width = 800, height = 600)
ggplot(pm10, aes(x = date, y = pm10, colour = state)) + # geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 20),se = t) + theme_bw() +
  #geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-16"))), linetype=4, colour="black") +
  geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-23"))), linetype=4, colour="black") +
  xlab("date") +
  ylab("pm10") +
  ggtitle("pm10 by german states (bundesländer)")
dev.off()

#######################################################################
# Subset data / plot shorter timeseies
no2 = no2[!(no2$date<'2018-03-01'),]
pm10 = pm10[!(pm10$date<'2018-03-01'),]

# no2
png(filename=paste0(savepath, sys.date(),"_no2_18_20.png"), width = 800, height = 600)
ggplot(no2, aes(x = date, y = no2, colour = state)) + #geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 20),se = t) + theme_bw() +
  #geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-16"))), linetype=4, colour="black") +
  geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-23"))), linetype=4, colour="black") +
  xlab("date") +
  ylab("no2") +
  ggtitle("no2 by german states (bundesländer)")
dev.off()

# pm10
png(filename=paste0(savepath, sys.date(),"_pm10_18_20.png"), width = 800, height = 600)
ggplot(pm10, aes(x = date, y = pm10, colour = state)) + # geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 20),se = t) + theme_bw() +
  #geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-16"))), linetype=4, colour="black") +
  geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-23"))), linetype=4, colour="black") +
  xlab("date") +
  ylab("pm10") +
  ggtitle("pm10 by german states (bundesländer)")
dev.off()

#######################################################################
# Subset data / even shorter
no2 = no2[!(no2$date<'2019-01-15'),]
pm10 = pm10[!(pm10$date<'2019-01-15'),]

# no2
png(filename=paste0(savepath, sys.date(),"_no2_20.png"), width = 800, height = 600)
ggplot(no2, aes(x = date, y = no2, colour = state)) + #geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 20),se = t) + theme_bw() +
  #geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-16"))), linetype=4, colour="black") +
  geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-23"))), linetype=4, colour="black") +
  xlab("date") +
  ylab("no2") +
  ggtitle("no2 by german states (bundesländer)")
dev.off()

# pm10
png(filename=paste0(savepath, sys.date(),"_pm10_20.png"), width = 800, height = 600)
ggplot(pm10, aes(x = date, y = pm10, colour = state)) + # geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 20),se = t) + theme_bw() +
  #geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-16"))), linetype=4, colour="black") +
  geom_vline(aes(xintercept = as.integer(as.posixct("2020-03-23"))), linetype=4, colour="black") +
  xlab("date") +
  ylab("pm10") +
  ggtitle("pm10 by german states (bundesländer)")
dev.off()

#######################################################################

