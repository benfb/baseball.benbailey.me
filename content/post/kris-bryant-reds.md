+++
date = "2017-04-05T18:48:26-04:00"
title = "Kris Bryant Loves the Reds"
+++

Kris Bryant was very good last year. The Reds were...not great last year. In fact, the Reds' bullpen was historically bad. Early in the season they [set a record for consecutive games allowing at least one run][runsal], and later in the season they [set a record for home runs allowed][hrsal].

Kris Bryant, of course, was the National League MVP.

This is what the MVP did against normal pitching in 699 plate appearances:

| BA | HR | OBP | SLG | OPS+ |
| --- | --- | --- | --- | --- |
| .292 | 29 | .385 | .554 | 149 |

This is what Kris Bryant did to Reds pitching in 88 plate appearances:

| BA | HR | OBP | SLG | tOPS+ |
| --- | --- | --- | --- | --- |
| .364 | 10 | .443 | .831 | 165 |

tOPS+ is a measure of how well a player performed in this split as opposed to their average. Imagine a normal Major League Baseball player. Now imagine Kris Bryant. The difference between these two players is less than the difference between Kris Bryant being pitched to by the Reds and normal Kris Bryant. Against-Reds Kris Bryant is to normal Kris Bryant as normal Kris Bryant is to a league-average hitter.

sOPS+ shows how well a player performed in a split compared to the league average in that split. Bryant's sOPS+ against the Reds was 211. That speaks for itself.

In fact, more than 25% of Bryant's home runs were against the Reds. A more modest 20.7% of his extra-base hits were against them.

This was Reds pitching against everyone:

| ERA | BA | HR | K/BB | sOPS+ |
| --- | --- | --- | --- | --- |
| 4.91 | .263 | 258 | 1.95 | 116 |

This was Reds Pitching against the Cubs:

| ERA | BA | HR | K/BB | tOPS+ |
| --- | --- | --- | --- | --- |
| 6.99 | .285 | 42 | 1.39 | 125 |

So the Reds were worse against the Cubs than against the league as a whole.

The advanced batted ball data backs up Bryant's Reds dominance:

| Reds? | Angle | Velocity | Distance | Barrel % |
| --- | --- | --- | --- | --- |
| No | 19.5 | 89.6 | 235.1 | 16.4% |
| Yes | 21.9 | 91.3 | 250.1 | 22.9% |

Against the Reds, Bryant's batted ball profile had a more optimal launch angle and greater velocity, distance, and barrel frequency.[^1]

The code for this analysis is located here.[^2] Much of the data for this post was collected from Baseball Reference.


[^1]: http://m.mlb.com/glossary/statcast/barreled-ball
[^2]: https://gist.github.com/benfb/d4c85ba9aac3ad8d5e0c3304eb2d696a

[runsal]: http://m.mlb.com/news/article/176059016/reds-bullpen-has-record-streak-allowing-runs/
[hrsal]: http://m.reds.mlb.com/news/article/201830542/reds-bullpens-sets-record-for-homers-allowed/
