# COVID-19: Air pollution in Germany 

*Last update: 18 April 2020*

This article presents a brief overview of the development of air pollution in Germany before and during [restrictions caused by the Covid-19 pandemic](https://github.com/Bixi81/COVID-19).

**1. Data**

The German Environmental Protection Agency ([Umweltbundesamt, UBA](https://www.umweltbundesamt.de/)) publishes air quality data for the pollutants NO2 and PM10 [online](https://www.umweltbundesamt.de/daten/luft/luftdaten/luftqualitaet/eJzrWJSSuMrIwMhA18BE19BiUUnmIkOzRXmpCxYVlyxYnOJWhJA0XJwSko-sNreKbVFuctPinMSS0w6eq-a9apQ7vjgnL_20g8o5F4dPFrMBSPIkdA==). The data can be downloaded using this R script. Data are available for over 400 measuring stations for NO2 and over 350 stations for PM10 across Germany. The data consist of hourly averages per pollutant and station, measured in µg/m³. Data from 2016 onwards is considered.

**2. Descriptive Overview and General Trends**

NO2 concentration tends to be higher during the winter month compared to the rest of the year. Over the years, a steady decrease of NO2 concentration can be found. The table below, shows the annual average of NO2 concentration over all German measuring stations considered in this analysis. 

| Year  | NO2  µg/m³ |
| ------------- | ------------- |
| 2016  | 25.5  |
| 2017  | 24.1  |
| 2018  | 23.7  |
| 2019  | 21.5  |

PM10 concentration tends to be higher in spring compared to the rest of the year.  Unlike in the case of NO2, PM10 concentration shows no clear pattern over the years. The table below, shows the annual average of PM10 concentration over all German measuring stations considered in this analysis. 

| Year  | PM10  µg/m³ |
| ------------- | ------------- |
| 2016  | 17.7  |
| 2017  | 17.6  |
| 2018  | 18.7  |
| 2019  | 15.9  |

**3. Air Pollution in Germany during the Covid-19 "Shutdown" **

From 23 March 2020 onwards, severe restrictions have been imposed all over Germany in order to slow down the spread of Covid-19 in the German population. These restrictions include closure of schools, kindergardens, universities and (most) shops. Find more details [here](https://github.com/Bixi81/COVID-19).

Looking at the mean of air pollution before and during the "shutdown" suggests that NO2 concentration was lower during the "shutdown" (18.2 compared to 23.4 µg/m³ on average over all stations). However, for PM10 the mean concentration increased during the "shutdown" (20.9 compared to 17.3 µg/m³ on average over all stations). 

Since there are important seasonal peaks in pollution levels, looking at overall mean values may mask the true effect of canges in pollution levels caused by the "shutdown". In order to get a sound estimated of the treatment effect, linear regression is used. For both pollutants, annual and monthly indicators are introduced (reference levels April / year 2019). In addition, controls for the location of individual stations are introduced. Locations are differentiated by stations which are close to industrial sites, roads, and other "background" sites. In addition, indicators for population density are available, i.e. indicating if a measuring station is located in a densly populated (city) area, in a suburb, in a rural or very rural environment. 

The figures below show the conventration of NO2 and PM10 respectively since 2018 over time. Find detailed density plots of the NO2 and PM10 concentration per month over several years below.

PLOTS

Regression results for NO2 can be found here, for PM10 here.

** 3.1 NO2 **

The regression results suggest that there is a positive response of NO2 pollution during the "shutdown", meaning that average concentration increased by about 1.3 units on average or about 6% against the average concentration of 2019. This effect is due to a unusually high concentration of NO2, observed during the "shutdown" so far, after controlling for seasonal effects. 

There are important differences in the change of the NO2 concentration during the "shutdown". A relatively pronounced reduction in NO2 is observed for stations neighbouring roads (-6.4 units). Also in densely populated areas (cities), the NO2 concentration decreased by about 1.5 units on average. However, these effects are offsetted by an increase of NO2 concentration at other locations (more rural areas and stations located close to industrial sites and "background" stations).

** 3.1 PM10 **

For PM10, the regression results suggest a pronounced positive response of PM10 pollution during the "shutdown", with an increase in average PM10 levels by about 9.1 units on average or about 57% against the average concentration of 2019.

Similar to the case of NO2 there are also spatial difference with respect to the PM10 concentration during the "shutdown". For stations located close to roads a lower level of PM10 is observed compared to before the "shutdown" (-1.5 units on average). Also in densely populated areas, such as cities, a lower concentration is observed on average (e.g. in cities -0.3 units on average).

** 4. Conclusion **

So far, NO2 and PM10 concentration in Germany showed a surprising and somewhat counter intuitive response to the Covid-19 "shutdown". While the concentration for both pollutants decreased at some sites, i.e. measuring stations located close to traffic "hot spots", the overall concentration across Germany increase for both pollutants. This effect occurs after controlling for seasonal effects, which have important influence on pollution levels. 

Sicne there is (so far) no data available regarding the reduction of economic activities during the "shutdown", it is not possible to identify the intensive margin. So far, only the extensive margin can be observed. However, it is important to identify the drivers of the observed increase in overall pollution as well as the extent to which specific factors - e.g. reduced road traffic - contribute to changes in air pollution. This is important because it allows an assessment of possible future options to achieve better air quality at selected sites. 


DENSITY PLOTS





