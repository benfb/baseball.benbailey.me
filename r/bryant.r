library(baseballr)
library(dplyr)

bryant <- scrape_statcast_savant_batter(start_date = "2016-04-03", end_date = "2016-10-03", batterid = 592178)

bryant_reds <- bryant %>%
  mutate(reds = away_team == "CIN" | home_team == "CIN") %>%
  group_by(reds) %>%
  summarize(
    avg_launchangle = mean(as.numeric(as.character(hit_angle)), na.rm = TRUE),
    avg_hitspeed = mean(hit_speed, na.rm = TRUE),
    avg_hitdistance = mean(hit_distance_sc, na.rm = TRUE),
    barrel_freq = mean(barrel, na.rm = TRUE)
  )
