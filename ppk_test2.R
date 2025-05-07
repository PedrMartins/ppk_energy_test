#install.packages("plotly")
#install.packages("rmarkdown")
library(plotly)
library(rmarkdown)

moving_average <- function(series, window = 5) {
  stats::filter(series, rep(1 / window, window), sides = 2)
}

ppk <- read.csv("ppk-30minutes_sample_2emeio_trans5min.csv")
#summary(ppk)
ppk$Timestamp.ms. <- round (ppk$Timestamp.ms. / (1000*60),  digits = 4)
ppk$Current.uA. <- round (ppk$Current.uA. / 1000,  digits = 3)

names(ppk) [c(1,2)] <- c("time_m", "current_mA")

ppk$ma5 <- moving_average(ppk$current_mA, window = 5)
ppk$ma10 <- moving_average(ppk$current_mA, window = 10)
ppk$ma15 <- moving_average(ppk$current_mA, window = 15)
ppk$ma20 <- moving_average(ppk$current_mA, window = 20)

plot_ppk <- plot_ly(data = ppk, x = ~time_m) |>
  add_lines(y = ~current_mA, name = "Current (mA)",
            line = list(color = 'blue')) |>
  layout(
    title = "Current milliampere",
    xaxis = list(title = "Time (minutes)"),
    yaxis = list(title = "Current (mA)")
    )



