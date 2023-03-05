library(ggplot2)
library(dplyr)
library(plotly)

# load the csv file
df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

df.2 <- df %>%
  mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
df.2$date <- as.Date(df.2$date)

df.3 <- df.2 %>%
  group_by(date, CheckoutType) %>%
  summarize(number = n())

plot.3 <- ggplot(df.3, aes(x = CheckoutType, y = number, fill = CheckoutType )) +
  geom_boxplot() +
  labs (x = "Checkout Vendor",
        y = "Number of Vendor",
        title = "Boxplot of Vendors",
        fill = "Vendors")

ggplotly(plot.3)






