library(ggplot2)
library(dplyr)
library("scales")
library(plotly)

# load the csv file
df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

df.2 <- df %>%
  mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
df.2$date <- as.Date(df.2$date)

df.3 <- df.2 %>%
  select(date, Checkouts, UsageClass) %>%
  group_by(date,UsageClass) %>%
  summarize(checkouts = sum(Checkouts, na.rm = T))

checkouts.plot <- ggplot(df.3, aes(x = date, y = checkouts, color = UsageClass)) +
  geom_line()+
  labs(x = "Date",
       y = "Total amount of checkouts (in thousand)",
       title = "Time Series of checkouts",
       color = "Usage Class") +
  scale_y_continuous(labels = label_number(suffix = " K", scale = 1e-3)) +
  theme_classic()

ggplotly(checkouts.plot)
