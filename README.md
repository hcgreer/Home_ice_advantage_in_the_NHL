# Home_ice_advantage_in_the_NHL

When teams are playing at home there is consistent talk about how having the crowd at their backs played a key role in determining the outcome of the game. This makes perfect sense when there is a key 3rd down for the away team in football and the crowd is doing everything in their power to keep the offense from hearing anything. Same goes for basketball when it just seems like the more into the game the crowd is the less the home team seems to miss. Though when looking at the sport of hockey the fans act much differently. Most noise from the fans comes after a significant event has already occurred, like a goal. Most of the time there are also long wait times between significant events in the game which mellows out the crowd. That brings me to the question, “Does the home team in the NHL have a statistical advantage over the away team?”

Grabbing data from 11 seasons of the NHL and calculating win percentage over that span we see there is a higher win percentage for the home team. The home team has a win percentage of 54%. Though this does not really prove there is an advantage at home and it does not quantify the advantage for being the home team.

# Applying Elo Rating System

To do this I need some way to hold the skill level of the teams constant so I can then run a statistical model on the data and see if there is some advantage for the home team. To do this I applied the Elo rating system to the NHL. The Elo rating system is one of the best rating systems around. It was developed and used by chess, but variants of this system are used in many different rating systems today. Now that is applied to the NHL I ran two models.


# Linear Model

The first model I ran was just a simple linear model. I used the difference in ratings for both teams to predict the differential of goals for a certain game. I am only interested in the intercept since I want the only difference between the teams to be where the game is played. The model returned that there is a slight advantage for the home team. With a confidence interval of 95% the estimated goal differential is 0.32 to 0.24. This is cool to see when teams are equal in skill the home team has a slight advantage but it is hard to interrupt how much of an advantage from that number.


# Logistic Model

For this reason I applied another statistical model. I ran the same data in a logistic regression model that would return the log odds of the home team winning based on the difference in rating. This model returned with a confidence interval of 95% that the estimated probability the home team will win is 58.2% to 51.2%. So if two equally skilled teams were to play each other the home team already has a more than 50% chance to win the game. Further looking into this the away team needs to have roughly about 60 more rating points than the home team to overcome the advantage of playing at home. 


# Conclusion

In conclusion it seems that there is a home advantage in the NHL. However, the models are far from perfect and there are many steps that can be taken to improve their estimated returns. Below I have linked a shiny app that can be used to further explore the historical data surrounding home advantage. There is also a tad that is all about the Elo rating system I applied to the NHL  and how its rankings compare to the traditional NHL standings. 

# Shiny App URL

https://hcgreer.shinyapps.io/nhl_home_ice_advantage/
  