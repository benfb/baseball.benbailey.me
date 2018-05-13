library(dplyr)
library(ggplot2)
library(knitr)

setwd(dir = "~/src/baseball-web/r/bullpen_update/")

relievers.2017 <- read.csv("savant_data2017rp.csv") %>% mutate(luck = xwoba - woba)
relievers.2018 <- read.csv("savant_data2018rp.csv") %>% mutate(luck = xwoba - woba)

luck <- inner_join(relievers.2017 %>% select(player_id, luck), relievers.2018 %>% select(player_id, luck), by = "player_id") %>%
  rename(luck.2017 = luck.x, luck.2018 = luck.y, team = player_id) %>%
  mutate(luck.diff = luck.2018 - luck.2017)

kable(luck %>% arrange(luck.diff), format = "markdown")

woba <- inner_join(relievers.2017 %>% select(player_id, woba), relievers.2018 %>% select(player_id, woba), by = "player_id") %>%
  rename(woba.2017 = woba.x, woba.2018 = woba.y, team = player_id) %>%
  mutate(woba.diff = woba.2018 - woba.2017)

kable(woba %>% arrange(woba.diff), format = "markdown")

xwoba <- inner_join(relievers.2017 %>% select(player_id, xwoba), relievers.2018 %>% select(player_id, xwoba), by = "player_id") %>%
  rename(xwoba.2017 = xwoba.x, xwoba.2018 = xwoba.y, team = player_id) %>%
  mutate(xwoba.diff = xwoba.2018 - xwoba.2017)

kable(xwoba %>% arrange(xwoba.diff), format = "markdown")

woba.xwoba.luck <- inner_join(inner_join(luck, xwoba, by = "team"), woba, by = "team")

change.in.xwoba <- relievers.2018 %>% mutate(diff = xwoba - relievers.2017$xwoba) %>% select(player_id, diff)

luck2017 <- ggplot(woba.xwoba.luck, aes(x = woba.2017, y = xwoba.2017)) +
  geom_point() +
  geom_smooth(method=lm, linetype="dashed", se=FALSE) +
  geom_text_repel(aes(label = team)) +
  labs(title = "Team Bullpen Luck (2017)",
       colour = "Team",
       x = "wOBA",
       y = "xwOBA")

ggsave("../../static/images/bullpen_update/luck_2017.png", luck2017, width = 6, height = 4)

luck2018 <- ggplot(woba.xwoba.luck, aes(x = woba.2018, y = xwoba.2018)) +
  geom_point() +
  geom_smooth(method=lm, linetype="dashed", se=FALSE) +
  geom_text_repel(aes(label = team)) +
  labs(title = "Team Bullpen Luck (2018)",
       colour = "Team",
       x = "wOBA",
       y = "xwOBA")

ggsave("../../static/images/bullpen_update/luck_2018.png", luck2018, width = 6, height = 4)

woba.over.years <- ggplot(woba.xwoba.luck, aes(x = woba.2017, y = woba.2018)) +
  geom_point() +
  geom_smooth(method=lm, linetype="dashed", se=FALSE) +
  geom_text_repel(aes(label = team)) +
  labs(title = "Team Bullpen Performance Between Years",
       colour = "Team",
       x = "2017 wOBA",
       y = "2018 wOBA")

ggsave("../../static/images/bullpen_update/woba_2017-18.png", woba.over.years, width = 6, height = 4)

xwoba.over.years <- ggplot(woba.xwoba.luck, aes(x = xwoba.2017, y = xwoba.2018)) +
  geom_point() +
  geom_smooth(method=lm, linetype="dashed", se=FALSE) +
  geom_text_repel(aes(label = team)) +
  labs(title = "Expected Team Bullpen Performance Between Years",
       colour = "Team",
       x = "2017 xwOBA",
       y = "2018 xwOBA")

ggsave("../../static/images/bullpen_update/xwoba_2017-18.png", xwoba.over.years, width = 6, height = 4)

luck.over.years <- ggplot(woba.xwoba.luck, aes(x = luck.2017, y = luck.2018)) +
  geom_point() +
  geom_smooth(method=lm, linetype="dashed", se=FALSE) +
  geom_text_repel(aes(label = team)) +
  labs(title = "Team Bullpen Luck Between Years",
       colour = "Team",
       x = "2017 xwOBA-wOBA",
       y = "2018 xwOBA-wOBA")

ggsave("../../static/images/bullpen_update/luck_2017-18.png", luck.over.years, width = 6, height = 4)

mean(woba.xwoba.luck$xwoba.diff)
mean(woba.xwoba.luck$woba.diff)
