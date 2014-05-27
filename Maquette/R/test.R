library("RJSONIO")
library("RCurl")
library("tm")

# get number of documents in a database
count <- fromJSON(getURL("http://localhost:9200/sepa/_count"))

n = count$count

# get all users bio information and name
url <- paste("http://localhost:9200/sepa/_search?type=tweet&language=en", sep = "")
json <- fromJSON(getURL(url))

# list of individual documents
lst <- json$hits$hits

# extract description from documents
desc <- sapply(lst, FUN = function(x) {
    ifelse(is.null(x$field$bio), "", x$field$bio)
})

# some documents don't have bio description
print(names <- unlist(sapply(lst, FUN = function(x) x$fields$login)))
names(desc) <- names
desc[12]  # example of user description
desc <- subset(desc, nchar(desc) > 0)

# Using TM

# create corpus for tm package
corpus <- Corpus(VectorSource(desc))

# eliminate extra whitespace
text <- tm_map(corpus, stripWhitespace)

# convert to lower case
text <- tm_map(text, tolower)

# remove english stopwords
text <- tm_map(text, removeWords, stopwords("english"))