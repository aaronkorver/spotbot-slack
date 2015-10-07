# Description:
#   movie quotes - the user starts a quote and spotbot completes it
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
#
# Author:
#   dak


module.exports = (robot) ->
# Wayne's World
  robot.hear ///party \s on \s #{robot.name}///i, (msg) ->
    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name
    msg.send "Party on, @#{sender}!"

# Top Gun
  robot.respond /i feel the need\b/i, (msg) ->
    msg.send "THE NEED FOR SPEED!"

# Labyrinth
  robot.respond /you remind me of the babe\b/i, (msg) ->
    msg.send "What babe?"

  robot.respond /babe with the power\b/i, (msg) ->
    msg.send "What power?"

  robot.respond /power of voodoo\b/i, (msg) ->
    msg.send "Who do?"

  robot.respond /you do\b/i, (msg) ->
    msg.send "Do what?"

  robot.respond /remind me of the babe\b/i, (msg) ->
    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name
    msg.send "Take a bow, @#{sender}!"

# Monty Python
  robot.hear /knights who say ni\b/i, (msg) ->
    msg.send "NI!"

# Star Wars
  robot.respond /i am your father\b/i, (msg) ->
    msg.send "NOOOOOOOOOOOOOO!"

  robot.respond /the odds of\b/i, (msg) ->
    msg.send "NEVER TELL ME THE ODDS!"

# Spaceballs
  robot.respond /the radar is jammed\b/i, (msg) ->
    msg.send "Raspberry. There's only one man who would dare give me the raspberry! LONE STARR!"

# Anchorman
  robot.respond /did you throw a trident\b/i, (msg) ->
    msg.send "Yeah, there were horses, and a man on fire, and I killed a guy with a trident."

# Airplane
  robot.respond /surely,? you can't be serious\b/i, (msg) ->
    msg.send "I am serious. And don't call me Shirley."

# Big Lebowski
  robot.respond /the dude abides\b/i, (msg) ->
    msg.send "The Dude abides. I don't know about you but I take comfort in that. It's good knowin' he's out there. The Dude. Takin' 'er easy for all us sinners. Shoosh. I sure hope he makes the finals."

# Avengers
  robot.respond /no one needs to break anything\b/i, (msg) ->
    msg.send "Clearly you've never made an omelette."

# Kindergarten Cop
  robot.respond /it might be a tumor\b/i, (msg) ->
    msg.send "It's not a tumor!"

# Ferris Bueller's Day Off
  robot.respond /bueller\b/i, (msg) ->
    msg.send "Um, he's sick. My best friend's sister's boyfriend's brother's girlfriend heard from this guy who knows this kid who's going with the girl who saw Ferris pass out at 31 Flavors last night. I guess it's pretty serious."

  robot.respond /what are we going to do\b/i, (msg) ->
    msg.send "The question isn't 'what are we going to do,' the question is 'what aren't we going to do?'"

# Beverly Hills Cop
  robot.respond /we're not gonna fall for a banana in the tailpipe\b/i, (msg) ->
    msg.send "You're not gonna fall for the banana in the tailpipe? It should be more natural, brother. It should flow out, like this - 'Look, man, I ain't fallin' for no banana in my tailpipe!'"

