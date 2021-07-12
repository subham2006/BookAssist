## Inspiration
With the transition back to in-person learning around the corner, we found the need for a system that allows students to transition back smoothly with academic aid as online learning has shown to be much less rigorous. In order to accomplish this goal, we created BookAssist.
## What it does
BookAssist allows students to scan pages of their textbooks that teachers would assign to them and select problems and topics that are difficult to them. They can then send these questions to their teachers who can view a list of all the requests of their classes and students. Teachers receive a shortened version of the problem or topic that the student has scanned on their web application and a list of topics that the class overall has. These topics and problems can then be targeted for future classes.
## How we built it
We used Flutter to create the mobile student application and teacher based web application and Firebase and Google Colab for our backend. We used several ML libraries for specific parts of our projects, more details in our github readme. We wanted to scan the images that the students send via firebase, so we used optical character recognition to convert images into text. We used Natural Language Processing to summarize the text, if the student uploaded a fairly long part of their textbook then we will summarize it to something that the teacher can digest. Finally, we had to find a way to detect what subject the student was talking about, so we could send to the correct teacher. We used scikit learn to make our own model.
## Challenges we ran into
We ran into trouble with integrating Firebase into Flutter as well as Backend bugs. Heroku also has a 500 mb limit on their app deployment, so we weren't able to use a server to host the app. Instead, we decided to use google colab because of the high amount of compute power that it has, possibly even beating out Heroku itself.
## Accomplishments that we're proud of
We are proud of overcoming our challenges as well as integration issues. Email integration was something that was not initially on our radar, but ended up being a really intuitive solution that made sense in the scope of our project.
## What we learned
We learned a lot about Flutter and Google Colab and how to create Web Apps from Mobile application links. We also learned how to deploy apps to Heroku, even though that didn't end up working it is an essential skill for future projects.
## What's next for BookAssist
In the future we plan to expand to schools and increase our span of outreach in order to help aid more students.


Youtube Link: 

<https://bookassist.web.app/#/>
