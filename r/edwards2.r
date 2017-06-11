library(baseballr)
library(Lahman)
library(dplyr)
library(ggplot2)
library(reshape2)
library(stringr)
library(tidyr)

playername_lookup <- function(string=NULL) {
  if (!exists("chadwick_player_lu_table")) {
    print("Be patient, this may take a few seconds...")
    print("Data courtesy of the Chadwick Bureau Register (https://github.com/chadwickbureau/register)")
    id <- string
    url <- "https://raw.githubusercontent.com/chadwickbureau/register/master/data/people.csv"
    chadwick_player_lu_table <- read.csv(url)
    assign("chadwick_player_lu_table", chadwick_player_lu_table, envir = .GlobalEnv)
    x <- chadwick_player_lu_table %>%
      filter(key_mlbam == id) %>%
      select(name_first, name_last)
    paste(as.character(x$name_first), as.character(x$name_last))
  }
  
  else {
    id <- string
    x <- chadwick_player_lu_table %>%
      filter(key_mlbam == id) %>%
      select(name_first, name_last)
    paste(as.character(x$name_first), as.character(x$name_last))
  }
}
qplot(miller$release_pos_x, miller$release_pos_y, color = miller$pitch_type, na.rm = T)
y <- daily_pitcher_bref("2016-04-03", "2016-10-03")
df2 <- fip_plus(y)
df2 %>% filter(IP > 30.0) %>% tail()

edwards <- scrape_statcast_savant_pitcher(start_date = "2017-04-01", end_date = "2017-05-24", pitcherid = 605218)

edwards_by_month <- edwards %>%
  filter(pitch_type != "NA", pitch_type != "CH") %>%
  group_by(game_date, pitch_type) %>%
  summarize(
    avg_velo = mean(as.numeric(as.character(release_speed)), na.rm = TRUE),
    avg_spin = mean(as.numeric(as.character(release_spin_rate)), na.rm = TRUE),
    avg_hitspeed = mean(launch_speed, na.rm = TRUE),
    avg_ext = mean(release_extension, na.rm = TRUE)
  )

ggplot(miller_by_month, aes(x = month, y = avg_break, colour = pitch_type)) +
  geom_point() +
  labs(title = "Andrew Miller 2016",
       colour = "Pitch Type",
       x = "Month",
       y = "Average Break")

ggsave("miller2016.png")

miller_by_year <- miller %>%
  separate(game_date, c("year", "month", "day")) %>%
  group_by(pitch_type, month, year) %>%
  summarize(
    avg_break = mean(as.numeric(as.character(break_length)), na.rm = TRUE),
    avg_spin = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE),
    avg_hitspeed = mean(hit_speed, na.rm = TRUE),
    avg_ext = mean(release_extension, na.rm = TRUE)
  ) %>% filter(pitch_type == "SL")

ggplot(miller_by_year, aes(x = month, y = avg_break, colour = year)) +
  geom_point() +
  labs(title = "Andrew Miller's Slider 2015-16",
       colour = "Year",
       x = "Month",
       y = "Average Break") +
  theme_fivethirtyeightlabels()

ggsave("millerSlider.png")