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

cj <- scrape_statcast_savant_pitcher(start_date = "2017-04-02", end_date = "2017-04-12", pitcherid = 605218)
cj$pitch_type
cj_group <- cj %>%
  filter(pitch_type != "NA") %>%
  group_by(pitch_type, game_date) %>%
  summarize(n = n(),
            avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE),
            avg_spin = mean(as.numeric(as.character(release_spin_rate)), na.rm = TRUE),
            avg_ext = mean(release_extension, na.rm = TRUE))

cj_tenth <- cj %>%
  filter(game_date == "2017-04-10") %>%
  filter(pitch_type != "NA") %>%
  select(pitch_id, pitch_type, start_speed, release_spin_rate, break_length, release_extension, description) %>%
  arrange(pitch_id)

cej <- scrape_statcast_savant_pitcher(start_date = "2016-04-06", end_date = "2016-10-15", pitcherid = 605218)
cej_group <- cej %>%
  filter(pitch_type != "NA") %>%
  group_by(pitch_type) %>%
  summarize(n = n(),
            avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE),
            avg_spin = mean(as.numeric(as.character(release_spin_rate)), na.rm = TRUE),
            avg_ext = mean(release_extension, na.rm = TRUE))
  