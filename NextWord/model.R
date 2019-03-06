library(tidyverse)
library(data.table)


getModel<-function(){
  model <- readRDS("model.rds")
  model<- setDT(model)
  return(model)
}

model<-getModel()

cleanInput<-function(input){
  
  convertedInput<-str_squish(input)
  if(length(grep("[[:punct:]]$", convertedInput, value=FALSE ))>0){
    convertedInput=''
  }
  else{
    convertedInputVec<-strsplit(convertedInput, "([^[:alpha:]][^[:alpha:]])|^[^[:alpha:]]|[^[:alpha:]]$") %>% unlist()
    convertedInput<-convertedInputVec[length(convertedInputVec)] %>% tolower()
    convertedInput<-gsub("(^[[:space:]]+|[[:space:]]+$)", "", convertedInput)
  }
  
  
  return(convertedInput)
}

getInputVector<-function(input){
  
  if(length(input)==0) input=''
  if(nchar(input)==0){
    vec=c('', '', '')
  }
  else{
    inputVectorPrep<-strsplit(input, " ")[[1]]
    l=length(inputVectorPrep)
    vec<-vector()
    vec[3]<-inputVectorPrep[l]
    if(l>1){
      vec[2]<-inputVectorPrep[l-1]
    }
    if(l>2){
      vec[1]<-inputVectorPrep[l-2]
    }
    
    vec[is.na(vec)] <- ''
    
  }
  vec
}
#model is globally loaded, please make sure that it is a data.t able
#model<-setDT(model)
getNextWord<-function(input, numberOfWords) {
  
  cleanInput<-cleanInput(input)
  
  output=""
  
  inputVector<-getInputVector(cleanInput)
  #use whole info
  
  wordsWholeInfo=arrange(model[ word1==inputVector[1] & word2==inputVector[2] & word3==inputVector[3]], desc(relativeFrequency))$word4
  output=head(wordsWholeInfo, n=numberOfWords)
  if(length(output)<numberOfWords){
    
    wordsWithout1=unique(arrange(model[word1=='' & word2==inputVector[2] & word3==inputVector[3]], desc(relativeFrequency))$word4)
    wordsWithout1=wordsWithout1[!(wordsWithout1 %in% output)]
    output=c(output, wordsWithout1)
    
    if(length(output) < numberOfWords){
      wordsWithout1And2=unique(arrange(model[word3==inputVector[3]], desc(relativeFrequency))$word4)
      wordsWithout1And2=wordsWithout1And2[!(wordsWithout1And2 %in% output)]
      output=c(output, wordsWithout1And2)
      if(length(output) < numberOfWords){
        wordsWithoutAll=unique(arrange(model, desc(relativeFrequency))$word4)
        wordsWithoutAll=wordsWithoutAll[!(wordsWithoutAll %in% output)]
        output=c(output, wordsWithoutAll)
      }
    }
  }
  
  return(head(output, n=numberOfWords))
}