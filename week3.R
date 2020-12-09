library(tm)

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

df <- readRDS(co_3gram_twitter_en)
df_nostop <- readRDS(co_3gram_nostop_twitter_en)

# 1. The guy in front of me just bought a pound of bacon, a bouquet, and a case of
head(df[grep("^case of", df[,1]),], 10)

# 2. You’re the reason why I smile everyday. Can you follow me please? It would mean the
head(df[grep("^mean the ", df[,1]),], 10)

# 3. Hey sunshine, can you follow me and make me the
head(df[grep("^me the", df[,1]),], 10)

# 4. Very early observations on the Bills game: Offence still struggling but the
head(df[grep("^struggling but", df[,1]),], 10)

# Didn't find so
str <- "Very early observations on the Bills game: Offence still struggling but the"
str <- removeWords(str, stopwords("en")); str <- gsub("\\s+", " ", str); str

# and then
head(df_nostop[grep("^still struggling", df_nostop[,1]),], 10)

# to adjust somenthing
rbind(df_nostop[grep("^still struggling crowd", df_nostop[,1]),], 
      df_nostop[grep("^still struggling defense", df_nostop[,1]),],
      df_nostop[grep("^still struggling referees", df_nostop[,1]),],
      df_nostop[grep("^still struggling players", df_nostop[,1]),])

# 5. Go on a romantic date at the
head(df[grep("^date at", df[,1]),], 10)

# 6. Well I’m pretty sure my granny has some old bagpipes in her garage I’ll dust them o and be on my

# 7. Ohhhhh #PointBreak is on tomorrow. Love that film and haven’t seen it in quite some
head(df[grep("^quite some ", df[,1]),], 10)

# Trying no-stop
head(df_nostop[grep("^romantic date", df_nostop[,1]),], 10)

# 8. After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little
head(df[grep("^on my ", df[,1]),], 10)

# 9. Be grateful for the good times and keep the faith during the
head(df[grep("^quite some ", df[,1]),], 10)

# 10. If this isn’t the cutest thing you’ve ever seen, then you must be
head(df[grep("^his little ", df[,1]),], 10)