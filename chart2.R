library(ggplot2)
library(dplyr)
library("scales")

# load the csv file
df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

df.2 <- df %>%
  mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
df.2$date <- as.Date(df.2$date)

df.3 <- df.2 %>%
  select(date, Checkouts) %>%
  group_by(date) %>%
  summarize(total = sum(Checkouts, na.rm = T))

df.4 <- df.2 %>%
  filter(CheckoutYear == PublicationYear) %>%
  select(date, Checkouts) %>%
  group_by(date) %>%
  summarize(total.2 = sum(Checkouts, na.rm = T))

df.5 <- merge(df.4, df.3)

ggplot(df.5) +
  geom_line(aes(x = date, y = total), color = "blue") +
  geom_line(aes(x = date, y = total.2), color = "red") +
  labs(
    x = "Date",
    y = "Total amount of checkouts (in thousand)",
    title = "Time Series of checkouts",
    subtitle = "Blue line: traces total checkouts 
Red line: traces total checkouts that have the same year as publish") +
  scale_y_continuous(labels = label_number(suffix = " K", scale = 1e-3)) +
  theme_classic()
