library(dplyr)
library(ggplot2)

# load the csv file
df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

# a list to store the variable
df.list <- list()

# Find the most popular book and times of checkouts
df.list$max.checkouts <- max(df$Checkouts)

df.list$max.checkouts.name <- df %>%
  filter(Checkouts == df.list$max.checkouts) %>%
  pull(Title)

# Find the most popular year 
df$PublicationYear <- as.numeric(gsub("([0-9]+).*$", "\\1", df$PublicationYear))
df.list$popular.year <- df %>%
  group_by(PublicationYear) %>%
  summarize(number = n()) %>%
  filter(PublicationYear != "NA") %>%
  filter(number == max(number, na.rm = T))  %>%
  pull(PublicationYear)

# difference between paper book and e-book
num.paper <- df %>%
  group_by(MaterialType) %>%
  summarize(number = n()) %>%
  filter(MaterialType == "BOOK") %>%
  pull(number)


num.ebook <- df %>%
  group_by(MaterialType) %>%
  summarize(number = n()) %>%
  filter(MaterialType == "EBOOK") %>%
  pull(number)

df.list$dif.ebook.book <- num.paper - num.ebook

# most popular checkout type
df.list$type <- df %>%
  group_by(CheckoutType) %>%
  summarize(number = n()) %>%
  filter(number == max(number, na.rm = T)) %>%
  pull(CheckoutType)



