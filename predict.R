source("clean_data.R")

library("data.table")
library("tm")

# t{n} represents a word-frequency table tanking n-grams into
# consideration.
t1 <- read.table("./Data/t1", stringsAsFactors = F)
t2 <- read.table("./Data/t2", stringsAsFactors = F)
t3 <- read.table("./Data/t3", stringsAsFactors = F)
t4 <- read.table("./Data/t4", stringsAsFactors = F)
t5 <- read.table("./Data/t5", stringsAsFactors = F)

table <- list(t1, t2, t3, t4, t5)

get_last_n_words <- function(sen, n){
  tail(strsplit(sen, split=" ")[[1]], n)
}

clean_sentence <- function(sen){
  cleaned_sen_corpus <- clean_text(sen)
  cleaned_sen <- data.frame(text=unlist(sapply(cleaned_sen_corpus, `[`, "content")),
                            stringsAsFactors=F)[1,1]
  cleaned_sen
}

predict <- function(sen){
  clean_sen <- clean_sentence(sen)
  answer = "Sorry, No match found :("
  for(n in 5:2){
    d <- table[[n]]
    sen_inp <- get_last_n_words(clean_sen, n-1)
    if(length(sen_inp)<n-1) {next}
    
    sen_inp <- paste(sen_inp, collapse = " ")
    result <- d[grep(paste0("^", sen_inp, " "), d$word),]
    
    no_of_results <- dim(result)[1]
    if(no_of_results==0) {next}
    answer <- rep(1: min(5, no_of_results) )
    for(i in 1:length(answer)){
      x <- result[i,]$word
      answer[i] <- get_last_n_words(x, 1)
    }
    break
  }
  answer
}