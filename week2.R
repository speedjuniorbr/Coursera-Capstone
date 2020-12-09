library(stringr)
library(tm)
library(ggplot2)
library(ngram)

# constants
co_text_attr_en = "./data/text_attr_en.rds"
co_tidy_twitter_en = "./data/tidy_twitter_en.rds"
co_tidy_nostop_twitter_en = "./data/tidy_nostop_twitter_en.rds"
co_1gram_twitter_en = "./data/1gram_twitter_en.rds"
co_2gram_twitter_en = "./data/2gram_twitter_en.rds"
co_3gram_twitter_en = "./data/3gram_twitter_en.rds"
co_1gram_nostop_twitter_en = "./data/1gram_nostop_twitter_en.rds"
co_2gram_nostop_twitter_en = "./data/2gram_nostop_twitter_en.rds"
co_3gram_nostop_twitter_en = "./data/3gram_nostop_twitter_en.rds"

# Data Cleaning
# read file
filepath <- "./data/final/en_US/en_US.twitter.txt"
con <- file(filepath) 
lines <- readLines(con, skipNul=TRUE) # 2360148 lines
close(con)

lines <- tolower(lines)
# split at all ".", "," and etc.
lines <- unlist(strsplit(lines, "[.,:;!?(){}<>]+")) # 5398319 lines

# replace all non-alphanumeric characters with a space at the beginning/end of a word.
lines <- gsub("^[^a-z0-9]+|[^a-z0-9]+$", " ", lines) # at the begining/end of a line
lines <- gsub("[^a-z0-9]+\\s", " ", lines) # before space
lines <- gsub("\\s[^a-z0-9]+", " ", lines) # after space
lines <- gsub("\\s+", " ", lines) # remove mutiple spaces
lines <- str_trim(lines) # remove spaces at the beginning/end of the line
saveRDS(lines, file=co_tidy_twitter_en)

# remove stop words
lines <- unlist(lapply(lines, function(line){removeWords(line, stopwords("en"))}))
lines <- str_trim(lines) # remove spaces at the beginning/end of the line
lines <- gsub("\\s+", " ", lines) # remove mutiple spaces
lines <- lines[nchar(lines)>0] # remove blank lines. reduce the elements from 5398319 to 5059787
saveRDS(lines, file=co_tidy_nostop_twitter_en)

# word frequence (1-gram)
words <- unlist(strsplit(lines, "\\s+"))
word.freq <- table(words)
df <- cbind.data.frame(names(word.freq), as.integer(word.freq))
names(df) <- c('word', 'freq')
row.names(df) <- df[,1]
df <- df[order(-df$freq),]
saveRDS(df, file=co_1gram_twitter_en)

# resolve non stop words (1-gram)
df <- readRDS(file=co_1gram_twitter_en)
idx <- unlist(lapply(stopwords("en"), function(stopword){return(which(df$word == stopword))}))
df <- df[-idx,]
saveRDS(df, co_1gram_nostop_twitter_en)

# word frequence (2-grams)
lines <- readRDS(co_tidy_twitter_en)
lines <- lines[str_count(lines, "\\s+")>0] # 4375507 lines
bigram <- ngram(lines, n=2) # this line takes long time. probably should sample the text first.
df <- get.phrasetable(bigram)
saveRDS(df, co_2gram_twitter_en)

# word frequence (3-grams)
lines <- readRDS(co_tidy_twitter_en)
# remove lines that contain less than 3 words, or ngram() would throw errors.
lines <- lines[str_count(lines, "\\s+")>1] # 3803575 lines
trigram <- ngram(lines, n=3) # this doesn't take long time surprisingly.
rm(lines)
df <- get.phrasetable(trigram)
saveRDS(df, co_3gram_twitter_en)
rm(df, trigram)

# resolve non-stop words
lines <- readRDS((co_tidy_nostop_twitter_en))
# remove lines that contain less than 3 words, or ngram() would throw errors.
lines <- lines[str_count(lines, "\\s+")>1] # 2780871 lines left
trigram <- ngram(lines, n=3) # this took less than a minute surprisingly.
rm(lines)
df <- get.phrasetable(trigram)
saveRDS(df, co_3gram_nostop_twitter_en)

