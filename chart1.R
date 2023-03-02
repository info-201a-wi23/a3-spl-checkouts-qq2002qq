library(ggplot2)
library(dplyr)
library(plotly)

# load the csv file
df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

# explore the trend between the material type and year
df.1 <- df %>%
  filter(MaterialType == c("BOOK", "EBOOK", "AUDIOBOOK", "VIDEODISC"))
df.1$CheckoutYear <- as.character(df.1$CheckoutYear)
df.1$count <- 1



a <- ggplot(df.1) +
  geom_col(aes(x = CheckoutYear, 
               y = count, 
               fill = MaterialType),
           position = position_stack()) +
  labs(x = "Year",
       y = "Amount of Material Types",
       title = "The changes of usage of different reading materials",
       fill = "Material Types")

ggplotly(a, tooltip = c("MaterialType", "CheckoutYear"))

