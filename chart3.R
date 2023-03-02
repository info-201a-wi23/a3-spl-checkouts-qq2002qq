library(ggplot2)
library(dplyr)

# load the csv file
df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

df.3 <- df %>%
  group_by(CheckoutType) %>%
  summarize(number = n()) %>%
  mutate(prop = round((number * 100 / sum(number)),digits = 2))

ggplot(df.3, aes(x = "", y = prop, fill = CheckoutType)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0)+
  geom_text(aes(label = ""), color = "white")+
  theme_void() +
  labs(title = "Popular Checkout Type Proportion",
       fill = "Vendors",
       subtitle = "Horizon takes 56.6%,
OverDrive takes 42.71%,
Zinio takes 0.32%,
Hoopla takes 0.26%,
Freegal take 0.1%")

knitr::kable(df.3)
