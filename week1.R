# 1. The en_US.blogs.txt file is how many megabytes?
filepath <- "./data/final/en_US/en_US.blogs.txt"
file.info(filepath)[,1]/1024/1000

# 2. The en_US.twitter.txt has how many lines of text?
filepath <- "./data/final/en_US/en_US.twitter.txt"
con <- file(filepath)
length(readLines(con))
close(con)

# 3. What is the length of the longest line seen in any of the three en_US data sets?
folder <- "./data/final/en_US/"
filelist <- list.files(path = folder)

l <- lapply(paste0(folder, filelist), function(filepath) {
     size <- file.info(filepath)[1]/1024/1000
     con <- file(filepath, open="r")
     lines <- readLines(con)
     nchars <- lapply(lines, nchar)
     maxchars <- max(unlist(nchars))
     nwords <- sum(sapply(strsplit(lines, "\\s+"), length))
     close(con)
     return(c(filepath, format(round(size, 2), nsmall=2), length(lines), maxchars, nwords))
})

df <- data.frame(matrix(unlist(l), nrow=3, byrow=TRUE))
names(df) <- c('file name', 'size(MB)', 'entries', 'longest line', 'total words')
df

# 4. In the en_US twitter data set, if you divide the number of lines where the word “love” (all lowercase) occurs by the number of lines the word “hate” (all lowercase) occurs, about what do you get?
filepath <- "./data/final/en_US/en_US.twitter.txt"
con <- file(filepath) 
lines <- readLines(con)
loves <- lapply(lines, function(line){grepl('love', line, ignore.case=FALSE)})
hates <- lapply(lines, function(line){grepl('hate', line, ignore.case=FALSE)})
close(con)
loves <- sum(unlist(loves))
hates <- sum(unlist(hates))
loves; hates; loves/hates

# 5. The one tweet in the en_US twitter data set that matches the word “biostats” says what?
filepath <- "./data/final/en_US/en_US.twitter.txt"
con <- file(filepath) 
lines <- readLines(con)
matches <- lapply(lines, function(line){grepl('biostats', line, ignore.case=FALSE)})
close(con)
result <- lines[unlist(matches)]; result

# 6. How many tweets have the exact characters “A computer once beat me at chess, but it was no match for me at kickboxing”. (I.e. the line matches those characters exactly.)
filepath <- "./data/final/en_US/en_US.twitter.txt"
con <- file(filepath) 
lines <- readLines(con)
matches <- lapply(lines, function(line){grepl('A computer once beat me at chess, but it was no match for me at kickboxing', line, ignore.case=FALSE)})
close(con)
result <- lines[unlist(matches)]; result; length(result)



