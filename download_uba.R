

mypath = "D:/airquality/"
savepath = "C:/Users/User/Documents/R/luftmesswerte/"

Sys.Date()
#####################################
# Load metadata
library(readr)
meta <- read_delim(paste0(mypath,"2020-04-05_metadata.csv"), ";", escape_double = FALSE, trim_ws = TRUE)
meta$unknown <- NULL
meta$hnumber <- NULL
stations = meta$station_id
max(stations)

options(timeout=36000) 
for (sid in stations){
  starttime = Sys.time()
  tryCatch({
    URL <- paste0("https://www.umweltbundesamt.de/api/air_data/v2/airquality/csv?date_from=2016-01-01&time_from=1&date_to=",Sys.Date(),"&time_to=24&station=",sid,"&lang=de")
    download.file(URL, paste0(mypath,sid,"_airqual.csv"), quiet = TRUE)
    Sys.sleep(5)
    print(paste0("Loading ", sid, " | took: ", (Sys.time() - starttime)))
  }, error = function(e){
    message(paste0("ERROR in ", sid, " | ", (Sys.time() - starttime)))
    print(e)})
}

#####################################
library(dplyr)
library(data.table)

files <- list.files(path=sprintf("%s",mypath), pattern="*airqual.csv", full.names=TRUE, recursive=FALSE)
myfiles = lapply(files, function(x) as.data.frame(read.csv(x, sep=";",header=T,na = "-",skip=0,encoding="UTF-8")))

# Remove last row in each df because it contains text describing the source
myfiles=lapply(myfiles, function(x) {x[1:(nrow(x)-1),]})
# Bind list to one df
a=dplyr::bind_rows(myfiles,.id = "column_label")

colnames(a)<-c("column_label","id2","date","pm10","o3","no2","index")
a$date=gsub("\'", "", a$date)
a$date=gsub("\\.", "-", a$date)
a$date=gsub("24:00", "23:59", a$date)
a$date = as.POSIXct(a$date,format="%d-%m-%Y %H:%M")

#####################################
# Merge metadata / save data
a = merge(a, meta, by="id2",all.x = T)
write.csv(x=a, paste0(savepath,"airquality_germany.csv"),row.names = FALSE)
