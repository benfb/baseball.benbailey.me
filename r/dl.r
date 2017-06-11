library(baseballr)
library(Lahman)
library(dplyr)
library(ggplot2)
library(reshape2)
library(stringr)
library(tidyr)
library(plotly)
library(ggthemes)

dl2016 <- read.csv("~/src/r/2016dldata.csv") %>%
  filter(Position == "RHP" | Position == "LHP") %>%
  filter(days >= 30)

dl2015 <- read.csv("~/src/r/2015dldata.csv") %>%
  filter(Position == "RHP" | Position == "LHP") %>%
  filter(Days.on.DL >= 30)

tj <- read.csv("~/src/r/tommyjohn.csv")

mlb.tj <- tj %>%
  filter(Level == "MLB") %>%
  filter(Year == 2015 | Year == 2016 | Year == 2017) %>%
  filter(Position == "P") %>%
  select(Player, TJ.Surgery.Date, Team, Throws, Age, Surgeon.s., Year)

savant_slider <- read.csv("~/src/r/savant15_17_slider_highmin.csv") %>%
  mutate(tj = player_name %in% tj$Player) %>%
  mutate(speed_diff = effective_speed - velocity) %>%
  mutate(speed_diff_pos = speed_diff >= 0)

p <- ggplot(savant_slider, aes(x=release_extension, y=effective_speed, text = paste("player:", player_name))) +
  geom_point(aes(colour = tj)) +
  labs(title = "Sliders and Tommy John",
       colour = "Tommy John?",
       x = "Release Extension",
       y = "Effective Speed")

p2 <- ggplotly(p)

api_create(p2)

p3 <- ggplot(savant_slider, aes(x=effective_speed, y=velocity, text = paste("player:", player_name))) +
  geom_point(aes(colour = tj, shape = speed_diff_pos)) +
  labs(title = "Sliders and Tommy John",
       colour = "Tommy John?",
       x = "Release Extension",
       y = "Effective Speed")

ggplotly(p3)

savant_slider %>%
  group_by(speed_diff_pos, tj) %>%
  summarise (n = n()) %>%
  mutate(freq = n / sum(n))

p4 <- ggplot(tj, aes(Age, fill = factor(Year), text = paste("player:", Player))) +
  geom_bar() +
  labs(title = "Tommy John and Age",
       x = "Age",
       y = "Count")

ggplotly(p4)

p5 <- ggplot(filter(tj, Age != "NA"), aes(Age, fill = factor(Team), text = paste("Player:", Player))) +
  geom_bar() +
  labs(title = "Tommy John and Age",
       x = "Age",
       y = "Count",
       fill = "Team")

ggplotly(p5)

api_create(p5)

usage <- read.csv("~/src/r/leaderboard.csv")
usage$FB. <- as.numeric(sub("%", "", usage$FB.))/100
usage$SL. <- as.numeric(sub("%", "", usage$SL.))/100
usage$CT. <- as.numeric(sub("%", "", usage$CT.))/100
usage$CB. <- as.numeric(sub("%", "", usage$CB.))/100
usage$CH. <- as.numeric(sub("%", "", usage$CH.))/100
usage$SF. <- as.numeric(sub("%", "", usage$SF.))/100
usage$KN. <- as.numeric(sub("%", "", usage$KN.))/100

usage_tj <- usage %>%
  mutate(tj = Name %in% tj$Player)

summary(aov(tj~FBv,usage_tj))

usage07 <- read.csv("~/src/r/leaderboard_07_17.csv") %>%
  mutate(tj = Name %in% tj$Player)

usage07$FB. <- as.numeric(sub("%", "", usage07$FB.))/100
usage07$SL. <- as.numeric(sub("%", "", usage07$SL.))/100
usage07$CT. <- as.numeric(sub("%", "", usage07$CT.))/100
usage07$CB. <- as.numeric(sub("%", "", usage07$CB.))/100
usage07$CH. <- as.numeric(sub("%", "", usage07$CH.))/100
usage07$SF. <- as.numeric(sub("%", "", usage07$SF.))/100
usage07$KN. <- as.numeric(sub("%", "", usage07$KN.))/100


ggplot(usage07, aes(x = tj, y = SLv + FBv, color = tj)) +
  geom_boxplot() +
  theme_fivethirtyeight() +
  labs(title = "Tommy John and Slider Velocity",
       x = "Age",
       y = "Count",
       color = "Tommy John?")

ggplotly(p6)

ggplot(tj, aes(x = Team, y = Age)) +
  geom_boxplot() +
  theme_fivethirtyeight() +
  labs(title = "Tommy John and Slider Velocity",
       x = "Age",
       y = "Count",
       color = "Tommy John?")


summary(aov(tj~SLv,usage07))

