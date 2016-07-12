# Takes in a text file and returns a VCorpus object after doing the necessary
# cleaning.
clean_text <- function(text_doc){
  
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