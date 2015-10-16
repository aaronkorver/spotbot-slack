# Description:
#   Laffy Taffy jokes
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot Laffy Taffy me - hubot responds with a Laffy Taffy joke

# Author:
#   Aaron.E.Reeves

laffyTaffyJokes = [
  {'question':'What starts with "T", is full of "T", and ends with "T"?','answer': 'a teapot'}
  {'question':'Teacher: Johnny, what is the definition of infinity?','answer':'Johnny: Tonight\'s homework assignment'}
  {'question':'How does a farmer mend his plants?','answer':'With a cabbage patch'}
  {'question':'When is a boxer like an astronomer?','answer': 'When he sees stars'}
  {'question':'Why did they bury the battery?','answer': 'Because it was dead'}
  {'question':'How do you spot a dogwood tree?','answer':'By its bark'}
  {'question':'Which garden has the most vegetables','answer':'Flash Garden'}
  {'question':'What did the noodles say to the butter?','answer':'Don\'t try and butter me up'}
  {'question':'How far did the witch fly?','answer':'Ghost to ghost'}
  {'question':'How does every baseball player get a hit?','answer':'He sings a song'}
  {'question':'What is a parasite?','answer':'Something you see in Paris'}
  {'question':'Why did the chicken cross the playground?','answer':'To get the other slide'}
  {'question':'When is homework not homework?','answer':'When it is turned into the teacher'}
  {'question':'Why did the skeleton cross the road?','answer':'To get to the body shop'}
  {'question':'What is in the middle of Paris?','answer':'The letter R'}
  {'question':'What\'s the funniest bone in your body?','answer':'The humerus'}
  {'question':'What\'s the best time to go to the dentist?','answer':'At tooth-hurty'}
  {'question':'What fish swims in the sky at night?','answer':'A starfish'}
  {'question':'What do ghosts like on their roast beef?','answer':'Grave-y'}
  {'question':'What is bow that you can\'t tie?','answer':'A rainbow'}
  {'question':'What did the wind say to the screen?','answer':'Just passing through'}
  {'question':'Which side of a mug should you put the handle on?','answer':'The outside'}
  {'question':'What has four legs and goes booo?','answer':'A cow with a cold'}
  {'question':'What is a caterpillar afraid of?','answer':'A dogerpillar'}
]

module.exports = (robot) ->
  robot.respond /laffy taffy me/i, (msg) ->
    joke = laffyTaffyJokes[random_index(laffyTaffyJokes)]
    msg.reply( "#{ joke.question }" )
    setTimeout ->
      msg.reply( "#{ joke.answer }" )
    , 3000

random_index = (array) ->
  Math.floor(Math.random() * array.length)