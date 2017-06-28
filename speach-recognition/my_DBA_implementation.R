library(dtwclust)
library(dtw)

myDBA = function(time_series, number_of_steps=100){
  average = vector("list", length=13)  # 13 mfccs koeficients per frame -> 13 time series describing one sound file
  
  for(mfcc_index in 1:13){
    C = time_series[[1]][, mfcc_index]
    
    for(step in 1:number_of_steps){
      associationTable = vector("list", length=length(C))
      
      for(index in 1:length(time_series)){
        current = time_series[[index]][, mfcc_index]
        
        result = dtw_basic(C, current, backtrack=TRUE, window.size = 5)
        #print(result)
        #print(result$index1)
        #print(result$index2)
        # print(current)
        
        for(i in 1:length(result$index1)){
          
          #print(result$index1[i])
          #print(result$index2[i])
          #print(current[result$index2[i]])
          
          associationTable[[result$index1[i]]] = append(associationTable[[result$index1[i]]], unname(current[result$index2[i]]))
        }
      }
      
      #print(associationTable)
      
      for(i in 1:length(C))
        C[i] = mean(associationTable[[i]])
    }
    average[[mfcc_index]] = C
  }
  
  return(do.call(rbind, average))
}


words = list("nula", "jedan", "dva", "tri", "cetiri", "pet", "sest", "sedam", "osam", "devet", "plus", "minus", "puta", "dijeljeno", "jednako")
elapsed_time = 0

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

  start.time <- Sys.time()
  average = myDBA(mfccs)
  end.time <- Sys.time()
  time.taken <- end.time - start.time
  print(time.taken)
  elapsed_time = elapsed_time + time.taken
  # print(average)
  
  filename = paste(directory, "/", word, "_averageMY.txt", sep="")

  print(filename)

  #print(average)
  write.table(average, file=filename, row.names=FALSE, col.names=FALSE, sep=" ")
}
print(elapsed_time)