path = 'C:/Users/Mira/Documents/DIPLOMSKI RAD - ALGORITAM PORAVNANJA VREMENSKIH NIZOVA/speach-recognition/Dataset/Train/'
word = "jedan"
directory = paste(path, word, sep="")

files = Sys.glob(file.path(directory, "*.txt"))

time_series = list()
i = 1
average = vector()
average1 = vector()

for(file in files){
  data = as.matrix(read.table(file ,header=FALSE,sep=" "))
  data = t(data)
  data = na.omit(data)

  if (grepl("average1", file)){
    average = data[, 1]
  }
  else if(grepl("average", file)){
    average1 = data[, 1]
  }
  else{
    time_series[[i]] = data[, 1]
    i = i + 1
  }
}

print(length(time_series))

plot(average, pch=0, col="red", bg="red", xlim=c(0, 50), ylim=c(-400, 0))
points(average1, col="blue")
lines(time_series[[1]])
lines(time_series[[2]])
lines(time_series[[3]])
lines(time_series[[4]])
lines(time_series[[5]])
lines(time_series[[6]])
lines(time_series[[7]])
lines(time_series[[8]])
lines(time_series[[9]])
lines(time_series[[10]])
lines(time_series[[11]])
lines(time_series[[12]])
lines(time_series[[13]])