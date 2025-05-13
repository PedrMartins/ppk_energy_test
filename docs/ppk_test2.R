#install.packages("plotly")
#install.packages("rmarkdown")
library(plotly)
library(rmarkdown)

moving_average <- function(series, window = 5) {
  stats::filter(series, rep(1 / window, window), sides = 2)
}


ppk <- read.csv("ppk-30minutes_sample_2emeio_trans5min.csv")
ppk_sensor <- read.csv("ppk_sensor-only.csv")
ppk_lora <- read.csv("ppk_just_send.csv")

#summary(ppk)

ppk$Timestamp.ms. <- round (ppk$Timestamp.ms.
                            / (1000*60),  digits = 4)
ppk_sensor$Timestamp.ms. <- round (ppk_sensor$Timestamp.ms.
                                   / (1000*60),  digits = 4)
ppk_lora$Timestamp.ms. <- round (ppk_lora$Timestamp.ms.
                                 / (1000*60),  digits = 4)
ppk$Current.uA. <- round (ppk$Current.uA.
                          / 1000,  digits = 3)
ppk_sensor$Current.uA. <- round (ppk_sensor$Current.uA.
                                 / 1000,  digits = 3)
ppk_lora$Current.uA. <- round (ppk_lora$Current.uA.
                               / 1000,  digits = 3)

names(ppk) [c(1,2)] <- c("time_m", "current_mA")
names(ppk_sensor) [c(1,2)] <- c("time_m", "current_mA")
names(ppk_lora) [c(1,2)] <- c("time_m", "current_mA")


plot_ppk_full <- plot_ly(data = ppk, x = ~time_m) |>
  add_lines(y = ~current_mA, name = "Current (mA)",
            line = list(color = 'blue')) |>
  layout(
    title = "Current milliampere",
    xaxis = list(title = "Time (minutes)"),
    yaxis = list(title = "Current (mA)")
    )

plot_ppk_sensor <- plot_ly(data = ppk_sensor, x = ~time_m) |>
  add_lines(y = ~current_mA, name = "Current (mA)",
            line = list(color = 'blue')) |>
  layout(
    title = "Current milliampere",
    xaxis = list(title = "Time (minutes)"),
    yaxis = list(title = "Current (mA)")
  )


plot_ppk_lora <- plot_ly(data = ppk_lora, x = ~time_m) |>
  add_lines(y = ~current_mA, name = "Current (mA)",
            line = list(color = 'blue')) |>
  layout(
    title = "Current milliampere",
    xaxis = list(title = "Time (minutes)"),
    yaxis = list(title = "Current (mA)")
  )
