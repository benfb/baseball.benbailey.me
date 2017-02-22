+++
Description = ""
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
date = "2017-02-22T18:45:40-05:00"
title = "An App!"
+++

This week I made a Shiny interface to the win probability and description services.
It can be viewed [here][bbbaseball]. To do this, I had to set up hosting for
both Shiny and my Elixir backend service. I also switched from embedding/posting
the plots on Plotly to embedding them in the new Shiny application, which should
help reduce costs. Learning more about Shiny made implementing the interface
relatively simple. The generation of the graphs is now abstracted into a
function that grabs JSON data from the API server I set up, which makes it much
easier to generate graphs for any desired game.

I would like to make several improvements to the graph next week. Including
scores would be helpful. Perhaps most interesting would be implementing
automatic "swing-point" detection and adding concise labels for the greatest
win probability changes in a game. Finally, it would be nice if there were a
way to view which teams played on which days, as right now it's difficult to
find a game that you want to graph.


[bbbaseball]: https://benfb.shinyapps.io/bbbaseball
