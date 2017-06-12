library(dtwclust)
library(dtw)

words = list("nula", "jedan", "dva", "tri", "cetiri", "pet", "sest", "sedam", "osam", "devet", "plus", "minus", "puta", "dijeljeno", "jednako")

for(word in words){
  path = 'C:/Users/Mira/Documents/DIPLOMSKI RAD - ALGORITAM PORAVNANJA VREMENSKIH NIZOVA/speach-recognition/Dataset/Train/'
  
  directory = paste(path, word, sep="")
  
  files = Sys.glob(file.path(directory, "*.txt"))
  mfccs = list()
  i = 1
  
  for(file in files){
    data = as.matrix(read.table(file ,header=FALSE,sep=" "))
    n = ncol(data)
    data=t(data)
    data = na.omit(data)
    mfccs[[i]] = data
    i = i + 1
  }
  
  average = DBA(mfccs)
  
  filename = paste(directory, "/", word, "_average.txt", sep="")
  
  print(filename)
  
  write.table(t(average), file=filename, row.names=FALSE, col.names=FALSE, sep=" ")
}