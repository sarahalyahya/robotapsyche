#Stronger Together - v.2

## Screen Recordings 
[Take 1](https://youtu.be/KpoRuM0xAxY)

[Take 2](https://youtu.be/cRHoZoJamm0)

## Screenshot

<img src= "https://github.com/sarahalyahya/robotapsyche/blob/9696cbcd3b0c31f448d89b1109e98a6ae342bf15/midterm/Overview.jpg" width = 50% height = 50%>

## Idea & Planning
For my midterm assignment, I wanted to build on top of my first assignment. My idea initially was to simulate a system where citizens/revolutionaries stick together and grow stronger than the dictator. To add more elements and complexity to this version, I expanded a bit upon the ecosystem, adding a shelter for weak revolutionaries and an elite class. I also changed the visual cues for clarity. I'll delve into more detail about each component, but here's a snap shot from my planning process, and a graphic explaining the different states in the ecosystem.
<img src="https://github.com/sarahalyahya/robotapsyche/blob/058e08d9f245fbe7b037a94b34ba49d00def97b9/midterm/midtermPlan.jpg" width=50% height=50%>
<img src="https://github.com/sarahalyahya/robotapsyche/blob/058e08d9f245fbe7b037a94b34ba49d00def97b9/midterm/Components.png" width=50% height=50%>

## Features / Behaviors
### Revolutionaries / Citizens
1. All Citizens are atracted to each other, using the attract function
2. Weaker citizens (with strength less than that of the predator), have a seek function that seeks shelter, which is the green area towards the left
3. They also flee from the Dictator, using an inverse seek function
4. If they collide with the dictator while weak, they "die" -- removed from arrayList, otherwise, they bounce off
5. They gain strength upon colliding with each other and bouncing off each other, and that's indicated by an increase in the opacity of their fill color
6. They lose strength upon colliding with Elites, and that's indicated by a decrease in the opacity of their fill color

### Dictator
1. The dictator is the strongest element on the screen at the beginning
2. It seeks citizens/revolutionaries to kill them
3. It bounces off strong citizens and off elites, it is also not allowed into the shelter zone 

### Elites
1. They are attracted to citizens/revolutionaries -- using a basic attract function
2. They maintain consistent strength, which is weaker than the dictator's strength
3. Upon colliding with revolutionaries, the revolutionaries lose strength, indicated by a decrease in opacity
4. However, they don't kill the revolutionaries 

### Safe Zone 
1. Using the seek and arrive functionalities, weak revolutionaries are attracted to this shelter/safe zone
2. The dictator and elites are not allowed in


## Issues
There is still a slight lack of consistent within the ecosystem that I'm confused about, it was initially very obvious, but it's now better after tweaking values. Still, I think that if I leave this code for a bit and then revisit it with a fresh eye later I'll be able to tweak the code and figure it out! Of course, all comments and feedback are welcome! (Please!!)
To be more specific, these inconsistencies are evident in some collisions not resulting in the coded outcome, e.g. two revolutionaries coliding without the strength increasing. I believe this might be due to the nested loop structure which deals with two elements at once only. I'm not sure how I would tackle this and would love advice

## Future Improvements 
For the future, I can work on: 
- the emergence of elites within the classes of revolutionaries -- kind of like traitors
- the birth of more revolutionaries upon collision 
- the ability to kill dictators past a specific threshold

## Reflection
This was a really exciting but very challenging assignment to work on! With a lot of elements to tweak, it's very easy to get overwhelmed. However, it is so interesting to see how different forces act together, and how a small difference in value can cause wonders of difference. My goal for this iteration was to achieve something more complex and idealistic. In assignment 1, after the revolutionaries achieve the dictator's strength, there's no going back -- they overthrow the dictator for good, in a sense. For this one, the presence of "corrupt elites" allows for the possibility of losing strength, making the system continue forever, unless all revolutionaries are stuck in the shelter. 







