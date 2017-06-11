library(baseballr)
library(Lahman)
library(dplyr)
library(ggplot2)
library(reshape2)
library(stringr)
library(tidyr)
library(ggthemes)
library(grid)
library(gridExtra)

hendricks <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 543294)

hendricks_by_inning <- hendricks %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN")

hendricks_by_inning_long <- melt(hendricks_by_inning, id = c("inning", "pitch_type"))

p1 <- ggplot(hendricks_by_inning_long, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Kyle Hendricks",
       colour = "Pitch",
       x = "Inning") +
  theme_fivethirtyeight()

scherzer <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 453286)

scherzer_by_inning <- scherzer %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN")

scherzer_by_inning_long <- melt(scherzer_by_inning, id = c("inning", "pitch_type"))

p2 <- ggplot(scherzer_by_inning_long, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Max Scherzer",
       colour = "Pitch") +
  theme_fivethirtyeight()

kluber_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 446372) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p3 <- ggplot(kluber_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Corey Kluber",
       colour = "Pitch") +
  theme_fivethirtyeight()

porcello_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 519144) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p4 <- ggplot(porcello_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Rick Porcello",
       colour = "Pitch") +
  theme_fivethirtyeight()

lester_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 452657) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p5 <- ggplot(lester_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Jon Lester",
       colour = "Pitch") +
  theme_fivethirtyeight()

verlander_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 434378) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p6 <- ggplot(verlander_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Justin Verlander",
       colour = "Pitch") +
  theme_fivethirtyeight()

price_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456034) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p7 <- ggplot(price_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "David Price",
       colour = "Pitch") +
  theme_fivethirtyeight()

cueto_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456501) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p8 <- ggplot(cueto_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Johnny Cueto",
       colour = "Pitch") +
  theme_fivethirtyeight()

bumgarner_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 518516) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(start_speed)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p9 <- ggplot(bumgarner_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Madison Bumgarner",
       colour = "Pitch") +
  theme_fivethirtyeight()


multi <- grid.arrange(p1, p2, p3, p4, p5, p6, p8, p7, p9, ncol = 3)
ggsave("velo.png", multi, width = 30, height = 20, units = "cm")

### SPIN

hendricks <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 543294)

hendricks_by_inning <- hendricks %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN")

hendricks_by_inning_long <- melt(hendricks_by_inning, id = c("inning", "pitch_type"))

p1 <- ggplot(hendricks_by_inning_long, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Kyle Hendricks",
       colour = "Pitch",
       x = "Inning") +
  theme_fivethirtyeight()

scherzer <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 453286)

scherzer_by_inning <- scherzer %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN")

scherzer_by_inning_long <- melt(scherzer_by_inning, id = c("inning", "pitch_type"))

p2 <- ggplot(scherzer_by_inning_long, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Max Scherzer",
       colour = "Pitch") +
  theme_fivethirtyeight()

kluber_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 446372) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p3 <- ggplot(kluber_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Corey Kluber",
       colour = "Pitch") +
  theme_fivethirtyeight()

porcello_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 519144) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p4 <- ggplot(porcello_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Rick Porcello",
       colour = "Pitch") +
  theme_fivethirtyeight()

lester_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 452657) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p5 <- ggplot(lester_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Jon Lester",
       colour = "Pitch") +
  theme_fivethirtyeight()

verlander_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 434378) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p6 <- ggplot(verlander_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Justin Verlander",
       colour = "Pitch") +
  theme_fivethirtyeight()

price_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456034) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p7 <- ggplot(price_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "David Price",
       colour = "Pitch") +
  theme_fivethirtyeight()

cueto_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456501) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p8 <- ggplot(cueto_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Johnny Cueto",
       colour = "Pitch") +
  theme_fivethirtyeight()

bumgarner_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 518516) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(spin_rate)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p9 <- ggplot(bumgarner_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Madison Bumgarner",
       colour = "Pitch") +
  theme_fivethirtyeight()


multi <- grid.arrange(p1, p2, p3, p4, p5, p6, p8, p7, p9, ncol = 3)
ggsave("spin.png", multi, width = 30, height = 20, units = "cm")

### BREAK

hendricks <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 543294)

hendricks_by_inning <- hendricks %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(break_length)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN")

hendricks_by_inning_long <- melt(hendricks_by_inning, id = c("inning", "pitch_type"))

p1 <- ggplot(hendricks_by_inning_long, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Kyle Hendricks",
       colour = "Pitch",
       x = "Inning") +
  theme_fivethirtyeight()

scherzer <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 453286)

scherzer_by_inning <- scherzer %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(break_length)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN")

scherzer_by_inning_long <- melt(scherzer_by_inning, id = c("inning", "pitch_type"))

p2 <- ggplot(scherzer_by_inning_long, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Max Scherzer",
       colour = "Pitch") +
  theme_fivethirtyeight()

kluber_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 446372) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(break_length)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p3 <- ggplot(kluber_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Corey Kluber",
       colour = "Pitch") +
  theme_fivethirtyeight()

porcello_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 519144) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(break_length)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p4 <- ggplot(porcello_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Rick Porcello",
       colour = "Pitch") +
  theme_fivethirtyeight()

lester_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 452657) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(break_length)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p5 <- ggplot(lester_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Jon Lester",
       colour = "Pitch") +
  theme_fivethirtyeight()

verlander_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 434378) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(break_length)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p6 <- ggplot(verlander_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Justin Verlander",
       colour = "Pitch") +
  theme_fivethirtyeight()

price_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456034) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(break_length)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p7 <- ggplot(price_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "David Price",
       colour = "Pitch") +
  theme_fivethirtyeight()

cueto_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456501) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(break_length)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p8 <- ggplot(cueto_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Johnny Cueto",
       colour = "Pitch") +
  theme_fivethirtyeight()

bumgarner_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 518516) %>%
  group_by(pitch_type, inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(break_length)), na.rm = TRUE)
  ) %>%
  filter(pitch_type != "NA", pitch_type != "IN", pitch_type != "PO") %>%
  melt(id = c("inning", "pitch_type"))

p9 <- ggplot(bumgarner_by_inning, aes(x=as.factor(inning), y=value, group=pitch_type, colour=pitch_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Madison Bumgarner",
       colour = "Pitch") +
  theme_fivethirtyeight()


multi <- grid.arrange(p1, p2, p3, p4, p5, p6, p8, p7, p9, ncol = 3)
ggsave("break.png", multi, width = 30, height = 20, units = "cm")

### EXIT VELOCITY

hendricks_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 543294) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_speed)), na.rm = TRUE)
  )

p1 <- ggplot(hendricks_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Kyle Hendricks") +
  theme_fivethirtyeight()

scherzer_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 453286) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_speed)), na.rm = TRUE)
  )

p2 <- ggplot(scherzer_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Max Scherzer") +
  theme_fivethirtyeight()

kluber_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 446372) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_speed)), na.rm = TRUE)
  )

p3 <- ggplot(kluber_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Corey Kluber") +
  theme_fivethirtyeight()

porcello_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 519144) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_speed)), na.rm = TRUE)
  )

p4 <- ggplot(porcello_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Rick Porcello") +
  theme_fivethirtyeight()

lester_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 452657) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_speed)), na.rm = TRUE)
  )

p5 <- ggplot(lester_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Jon Lester") +
  theme_fivethirtyeight()

verlander_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 434378) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_speed)), na.rm = TRUE)
  )

p6 <- ggplot(verlander_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Justin Verlander") +
  theme_fivethirtyeight()

price_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456034) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_speed)), na.rm = TRUE)
  )

p7 <- ggplot(price_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "David Price") +
  theme_fivethirtyeight()

cueto_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456501) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_speed)), na.rm = TRUE)
  )

p8 <- ggplot(cueto_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Johnny Cueto") +
  theme_fivethirtyeight()

bumgarner_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 518516) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_speed)), na.rm = TRUE)
  )

p9 <- ggplot(bumgarner_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Madison Bumgarner") +
  theme_fivethirtyeight()


multi <- grid.arrange(p1, p2, p3, p4, p5, p6, p8, p7, p9, ncol = 3)
ggsave("hitspeed.png", multi, width = 30, height = 20, units = "cm")

### HIT DISTANCE

hendricks_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 543294) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_distance_sc)), na.rm = TRUE)
  )

p1 <- ggplot(hendricks_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Kyle Hendricks") +
  theme_fivethirtyeight()

scherzer_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 453286) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_distance_sc)), na.rm = TRUE)
  )

p2 <- ggplot(scherzer_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Max Scherzer") +
  theme_fivethirtyeight()

kluber_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 446372) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_distance_sc)), na.rm = TRUE)
  )

p3 <- ggplot(kluber_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Corey Kluber") +
  theme_fivethirtyeight()

porcello_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 519144) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_distance_sc)), na.rm = TRUE)
  )

p4 <- ggplot(porcello_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Rick Porcello") +
  theme_fivethirtyeight()

lester_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 452657) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_distance_sc)), na.rm = TRUE)
  )

p5 <- ggplot(lester_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Jon Lester") +
  theme_fivethirtyeight()

verlander_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 434378) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_distance_sc)), na.rm = TRUE)
  )

p6 <- ggplot(verlander_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Justin Verlander") +
  theme_fivethirtyeight()

price_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456034) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_distance_sc)), na.rm = TRUE)
  )

p7 <- ggplot(price_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "David Price") +
  theme_fivethirtyeight()

cueto_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 456501) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_distance_sc)), na.rm = TRUE)
  )

p8 <- ggplot(cueto_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Johnny Cueto") +
  theme_fivethirtyeight()

bumgarner_by_inning <- scrape_statcast_savant_pitcher(start_date = "2016-04-05", end_date = "2016-10-15", pitcherid = 518516) %>%
  group_by(inning) %>%
  summarize(
    avg_mph = mean(as.numeric(as.character(hit_distance_sc)), na.rm = TRUE)
  )

p9 <- ggplot(bumgarner_by_inning, aes(x=as.factor(inning), y=avg_mph, group=1)) +
  geom_line() +
  geom_point() +
  labs(title = "Madison Bumgarner") +
  theme_fivethirtyeight()


multi <- grid.arrange(p1, p2, p3, p4, p5, p6, p8, p7, p9, ncol = 3)
ggsave("hitdistance.png", multi, width = 30, height = 20, units = "cm")
