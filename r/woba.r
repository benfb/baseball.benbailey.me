library(baseballr)
library(Lahman)
library(dplyr)
library(ggplot2)

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

x <- daily_batter_bref("2016-04-03", "2016-10-03")
df <- woba_plus(x)
filter(df, PA > 100) %>% tail()

df2016 <- summarize(group_by(filter(Batting, yearID == 2016),
                             playerID),
                    season = first(yearID),
                    AB = sum(AB), uBB = sum(BB),
                    X1B = sum(H - X2B - X3B - HR),
                    X2B = sum(X2B), X3B = sum(X3B),
                    HBP = sum(HBP), SF = sum(SF),
                    HR = sum(HR), SH = sum(SH), SO = sum(SO))
df2016_q <- filter(df2016, AB >= 400)
woba <- woba_plus(df2016_q)
head(select(woba, playerID, wOBA, wOBA_CON))

y <- daily_pitcher_bref("2016-04-03", "2016-10-03")
df2 <- fip_plus(y)
df2 %>% filter(IP > 30.0) %>% tail()

cej <- scrape_statcast_savant_pitcher(start_date = "2016-04-06", end_date = "2016-10-15", pitcherid = 605218)
# cej %>% group_by(pitch_type) %>% summarize(count = n(), avg_mph = mean(start_speed, na.rm = TRUE))
# cej %>% group_by(pitch_type) %>% summarize(count = n(),
#                                            avg_mph = mean(start_speed, na.rm = TRUE),
#                                            avg_spin = mean(spin_rate, na.rm = TRUE),
#                                            avg_hitspeed = mean(hit_speed, na.rm = TRUE),
#                                            avg_ext = mean(release_extension, na.rm = TRUE))
# 
# cej %>% group_by(catcher) %>% summarize(count = n(),
#                                            avg_mph = mean(start_speed, na.rm = TRUE),
#                                            avg_spin = mean(spin_rate, na.rm = TRUE),
#                                            avg_hitspeed = mean(hit_speed, na.rm = TRUE),
#                                            avg_ext = mean(release_extension, na.rm = TRUE))
# 
# cej %>% group_by(pitch_type, catcher) %>% summarize(
#                                         n = n(),
#                                         avg_mph = mean(start_speed, na.rm = TRUE),
#                                         avg_spin = mean(spin_rate, na.rm = TRUE),
#                                         avg_hitspeed = mean(hit_speed, na.rm = TRUE),
#                                         avg_ext = mean(release_extension, na.rm = TRUE))

cej_by_catcher <- cej %>%
  filter(pitch_type != "CH", pitch_type != "IN") %>%
  group_by(pitch_type, catcher) %>%
  summarize(n = n(),
            avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE),
            avg_spin = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE),
            avg_hit_distance = mean(hit_distance_sc, na.rm = TRUE),
            avg_hit_speed = mean(hit_speed, na.rm = TRUE),
            avg_hit_angle = mean(hit_angle, na.rm = TRUE),
            avg_barrel = mean(barrel, na.rm = TRUE),
            avg_ext = mean(release_extension, na.rm = TRUE)) %>%
  mutate(pitch_pct = n/sum(n))


ggplot(cej_by_catcher, aes(x=avg_hit_speed,
                           y=avg_hit_distance,
                           colour = sapply(as.factor(catcher), playername_lookup),
                           size = n,
                           shape = pitch_type)) +
  geom_point() +
  labs(title = "Carl Edwards Hit Velocity vs. Hit Distance",
       colour = "Catcher",
       size = "Count",
       shape = "Pitch Type",
       x = "Average Hit Velocity",
       y = "Average Hit Distance")
ggsave("cevd2.png")

ggplot(cej_by_catcher, aes(x=avg_spin,
                           y=avg_mph,
                           colour = sapply(as.factor(catcher), playername_lookup),
                           size = n,
                           shape = pitch_type)) +
  geom_point() +
  labs(title = "Carl Edwards Spin vs. Velocity",
       colour = "Catcher",
       size = "Count",
       shape = "Pitch Type",
       x = "Average Spin",
       y = "Average Velocity")
ggsave("cesv2.png")

require("pander")
panderOptions("table.split.table", Inf)

cej_by_catcher <- cej %>%
  filter(game_date != "2016-08-13", game_date != "2016-09-17") %>%
  filter(pitch_type != "CH", pitch_type != "IN") %>%
  group_by(pitch_type) %>%
  summarize(n = n(),
            avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE),
            avg_spin = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE),
            avg_hit_distance = mean(hit_distance_sc, na.rm = TRUE),
            avg_hit_speed = mean(hit_speed, na.rm = TRUE),
            avg_hit_angle = mean(hit_angle, na.rm = TRUE),
            avg_barrel = mean(barrel, na.rm = TRUE),
            avg_ext = mean(release_extension, na.rm = TRUE)) %>%
  mutate(pitch_pct = n/sum(n))

# bad_outings <- cej %>%
#   filter(game_date == "2016-08-13" | game_date == "2016-09-17") %>%
#   filter(pitch_type != "CH", pitch_type != "IN") %>%
#   group_by(pitch_type) %>%
#   summarize(n = n(),
#             avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE),
#             avg_spin = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE),
#             avg_hit_distance = mean(hit_distance_sc, na.rm = TRUE),
#             avg_hit_speed = mean(hit_speed, na.rm = TRUE),
#             avg_hit_angle = mean(hit_angle, na.rm = TRUE),
#             avg_barrel = mean(barrel, na.rm = TRUE),
#             avg_ext = mean(release_extension, na.rm = TRUE)) %>%
#   mutate(pitch_pct = n/sum(n))


ggplot(cej_by_catcher, aes(x=avg_spin,
                           y=avg_mph,
                           colour = sapply(as.factor(catcher), playername_lookup),
                           size = n,
                           shape = pitch_type)) +
  geom_point() +
  labs(title = "Carl Edwards Spin vs Velocity",
       colour = "Catcher",
       size = "Count",
       shape = "Pitch Type",
       x = "Average Spin",
       y = "Average Velocity")
ggsave("mtcars3.png")

# hendricks <- scrape_statcast_savant_pitcher(start_date = "2016-04-06", end_date = "2016-10-15", pitcherid = 543294)
# 
# hendricks_by_catcher <- hendricks %>%
#   group_by(pitch_type, catcher) %>%
#   summarize(n = n(),
#             avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE),
#             avg_spin = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE),
#             avg_hitspeed = mean(hit_speed, na.rm = TRUE),
#             avg_ext = mean(release_extension, na.rm = TRUE),
#             catcher_name = playername_lookup(catcher)) %>%
#   mutate(pitch_pct = n/sum(n))
# 
# ggplot(hendricks_by_catcher, aes(x=avg_spin,
#                            y=avg_hitspeed,
#                            colour = as.factor(catcher_name),
#                            size = n,
#                            shape = pitch_type)) +
#   geom_point() +
#   labs(title = "Kyle Hendricks", colour = "Catcher", size = "Count", shape = "Pitch Type", x = "Average Spin Rate", y = "Average Exit Velocity")
# 
# ggplot(hendricks_by_catcher, aes(x=avg_mph,
#                                  y=avg_hitspeed,
#                                  colour = as.factor(catcher_name),
#                                  size = n,
#                                  shape = pitch_type)) +
#   geom_point() +
#   labs(title = "Kyle Hendricks",
#        colour = "Catcher",
#        size = "Count",
#        shape = "Pitch Type",
#        x = "Average MPH",
#        y = "Average Exit Velocity")
# 
