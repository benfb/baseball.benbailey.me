library(prophet)
library(dplyr)
library(ggplot2)

df <- read.csv('example_wp_peyton_manning.csv') %>%
  mutate(y = log(y))

m <- prophet(df)

future <- make_future_dataframe(m, periods = 365)
tail(future)

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

plot(m, forecast)
prophet_plot_components(m, forecast)

cubs.csv <- read.csv('cubs2.csv')

wl_to_pct <- function(wl){
  arr <- unlist(strsplit(as.character(cubs.csv$W.L.1[5]), "-"))
  w <- as.numeric(arr[1])
  l <- as.numeric(arr[2])
  return(w/w+l)
}

cubs <- data.frame(ds = cubs.csv$Date, y = cubs.csv$W.L.1) %>%
  mutate(y = log(wl_to_pct(y)), ds = as.Date(ds, "%A %b %d"))

m <- prophet(cubs)

future <- make_future_dataframe(m, periods = 365)
tail(future)

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

plot(m, forecast)
prophet_plot_components(m, forecast)