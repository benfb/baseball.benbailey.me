+++
Tags = ["Development","golang"]
Description = ""
date = "2017-03-03T12:46:26-05:00"
title = "Events and Dynamic UI"
+++

This week I focused on improving the usability of the Shiny app. I used Shiny's
`renderUI` function to dynamically generate the options for the game select
dropdown. I also set up a baseball API [here][API], and added another API
endpoint to get the list of games that happened on any given day.

One of the nicer things I added to the Shiny app was the use of the `tryCatch`
function to hide confusing error messages from the user, like this:

```r
tryCatch({
     splitGames <- unlist(strsplit(input$game, " @ "))
     away <- teams[which(grepl(splitGames[1], names(teams)))]
     home <- teams[which(grepl(splitGames[2], names(teams)))]

     data <- getEvents(year, month, day, away, home)
     sliderInput("event", "Event:",
                 min = 1, max = length(data$probabilities),
                 value = length(data$probabilities), sep = 1)
   }, error = function(e) {
     stop("That is not a valid event")
   })
```

In reality, much of my week was spent fighting with R's several methods of
dealing with strings and arrays. Most of the changes this week were in the front
end user-facing part of the app, so I'm excited to work more on the backend next
week (maybe finally improving the win probability calculation?). As a side note,
the app does generally work for spring training games (as long as Gameday is
working at the moment).

[API]: http://bbbaseball.herokuapp.com
