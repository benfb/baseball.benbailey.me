+++
Description = ""
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
date = "2017-02-07T18:38:53-05:00"
title = "Descriptions and Probabilities"

+++

This week I mostly focused on experimenting with the Retrosheet and MLB Gameday API formats.
Using the `baseball` umbrella application combined with R and Plotly, I generated a win expectancy
graph for a random game.

In any given situation, the win expectancy is equivalent to the percentage of games
that teams in that exact situation went on to win. To calculate the win probability of
a situation, the application converts the situation into a hash using the number of outs,
inning, number and position of base runners, and the current score, then looks it up in a
table of historical win probabilities. This table was calculated using [Greg Stoll's scripts][gs]
and [Retrosheet][rs] data. The code for the win expectancy service can be found
[here][win-ex], and the general downloader's source is [here][slurper]. What follows
is an example of a manually-generated win expectancy graph of the game that occurred
on May 10th of last season between the Padres and the Cubs.

First, we utilize the two functions `probabilities_from_game/2` and `descriptions_from_game/2`
to get vectors of win expectancies and descriptions of every event that occurred in the game:

```elixir
iex(1)> BaseballSlurper.Server.probabilities_from_game("2016-05-10", ["sdn", "chn"])
[[0.5652355266525733, 0.5826495329514373, 0.593064127007075],
 [0.5669081828973761, 0.5470361185179661, 0.534091190836288],
 [0.5569277494191046, 0.5742743999613658, 0.5803200220916497],...]

iex(2)> BaseballSlurper.Server.descriptions_from_game("2016-05-10", ["sdn", "chn"])
[["Jon Jay grounds out, second baseman Ben Zobrist to first baseman Anthony Rizzo.",
  "Wil Myers flies out to center fielder Dexter Fowler.",
  "Matt Kemp lines out to center fielder Dexter Fowler."],
 ["Dexter Fowler strikes out swinging.",
  "Jason Heyward lines out to center fielder Jon Jay.",
  "Kris Bryant lines out to right fielder Matt Kemp."],...]
```

We can then plug these two vectors into R to get an interactive win expectancy graph with Plotly:

```r
library(plotly)
Sys.setenv("plotly_username" = "benfb")
Sys.setenv("plotly_api_key" = API_KEY)
probabilities <- c(PROBABILITY_VECTOR)
x <- seq_along(y)
event <- c(DESCRIPTION_VECTOR)
data <- data.frame(x, y, event)

kb <- list(
  xref = 'paper',
  yref = 'y',
  x = seq(0, 1, by=(1/length(x)))[23],
  y = probabilities[23],
  xanchor = 'right',
  yanchor = 'middle',
  text = 'K Bryant Double',
  font = list(family = 'Arial',
              size = 16,
              color = 'rgba(67,67,67,1)'),
  showarrow = FALSE)

ad <- list(
  xref = 'paper',
  yref = 'y',
  x = seq(0, 1, by=(1/length(x)))[72],
  y = probabilities[72],
  xanchor = 'right',
  yanchor = 'middle',
  text = 'A Dickerson Home Run',
  font = list(family = 'Arial',
              size = 16,
              color = 'rgba(67,67,67,1)'),
  showarrow = FALSE)

p <- plot_ly(
  data,
  x = seq_along(y),
  y = probabilities,
  type = 'scatter',
  mode = 'lines',
  text = event) %>%
layout(
  title = 'SDN @ CHN 2016-05-10',
  xaxis = list(title = 'Game Event'),
  yaxis = list(title = 'Home Team Win Probability')) %>%
layout(annotations = list(kb, ad))
```

This R code yields the following chart:

<iframe width="100%" height="500" frameborder="0" scrolling="no" src="//plot.ly/~benfb/0.embed"></iframe>

For comparison, the Fangraph's win expectancy graph is [here][fg], and you can find
the full video of the game on [MLB's YouTube channel][mlb][^1].

The next step will be to automate this process and look into self-hosting
the graphs instead of going through Plotly's rate-limited API.

[^1]: The date in the title of this video is actually incorrect. It's actually the game from May 10th.

[gs]: https://gregstoll.dyndns.org/~gregstoll/baseball/stats.html
[rs]: http://www.retrosheet.org
[win-ex]: https://github.com/benfb/baseball/tree/master/apps/baseball_win_ex
[slurper]: https://github.com/benfb/baseball/tree/master/apps/baseball_slurper
[fg]: http://www.fangraphs.com/wins.aspx?date=2016-05-10&team=Cubs&dh=0&season=2016
[mlb]: https://www.youtube.com/watch?v=wGqoB_8hNtw
