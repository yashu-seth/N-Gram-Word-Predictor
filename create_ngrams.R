setwd("C:/work/R/Coursera-SwiftKey/final/en_US/")


library('tm')
library('stringi')
library('magrittr')
library('data.table')
library('RWeka')
library('slam')

sample_data_small <- readLines("sample_data_6lk.txt", encoding = "UTF-8",
                               warn = FALSE)
# sample_data_small <- sample_data_small[sample(1:length(sample_data_small),
#                                               30000, replace = F)]

#############################################################################

# Takes in a text file and returns a VCorpus object after doing the necessary
# cleaning.
convert_text <- function(text_doc){
  
  text_doc <- iconv(text_doc, "latin1", "ASCII", sub=" ");
  text_doc <- gsub("[^[:alpha:][:space:][:punct:]]", "", text_doc);
  
  text_corpus <- VCorpus(VectorSource(text_doc))
  
  text_corpus <- tm_map(text_corpus, content_transformer(tolower),
                        lazy = TRUE)
  text_corpus <- tm_map(text_corpus,
                        content_transformer(removePunctuation))
  text_corpus <- tm_map(text_corpus,
                        content_transformer(removeNumbers))
  
  text_corpus <- tm_map(text_corpus, stripWhitespace)
  
  text_corpus
}

##############################################################################

sample_data_small <- convert_text(sample_data_small)

##############################################################################

# Functions to create the n-gram tokens. Used while constructing the term document
# matrices.
unigram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
bigram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
trigram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
tetragram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
pentagram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 5, max = 5))

##############################################################################

##############################################################################

create_freq_table <- function(tdm){
  # This row_sums function is from slam package.
  freq <- sort(row_sums(tdm, na.rm=TRUE), decreasing=TRUE)
  word <- names(freq)
  data.table(word=word, freq=freq)
}

###############################################################################

unigram_tdm <- TermDocumentMatrix(sample_data_small,
                                  control = list(bounds=list(global = c(2, Inf))))
d1 <- create_freq_table(unigram_tdm)
write.table(d1, file = "t1")


bigram_tdm <- TermDocumentMatrix(sample_data_small,
                                 control = list(tokenize=bigram_tokenizer,
                                                bounds=list(global = c(2,Inf))))
d2 <- create_freq_table(bigram_tdm)
write.table(d2, file = "t2")


trigram_tdm <- TermDocumentMatrix(sample_data_small,
                                  control = list(tokenize=trigram_tokenizer,
                                                 bounds=list(global = c(2,Inf))))
d3 <- create_freq_table(trigram_tdm)
write.table(d3, file = "t3")

tetragram_tdm <- TermDocumentMatrix(sample_data_small,
                                    control = list(tokenize=tetragram_tokenizer,
                                                   bounds=list(global = c(2,Inf))))

d4 <- create_freq_table(tetragram_tdm)
write.table(d4, file = "t4")

pentagram_tdm = TermDocumentMatrix(sample_data_small,
                                   control = list(tokenize=pentagram_tokenizer,
                                                  bounds=list(global = c(2,Inf))))

d5 <- create_freq_table(pentagram_tdm)
write.table(d5, file = "t5")

###############################################################################
