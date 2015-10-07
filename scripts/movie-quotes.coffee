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
  robot.respond /surely, you can't be serious\b/i, (msg) ->
    msg.send "I am serious. And don't call me Shirley."

# Big Lebowski
  robot.respond /the dude abides\b/i, (msg) ->
    msg.send "The Dude abides. I don't know about you but I take comfort in that. It's good knowin' he's out there. The Dude. Takin' 'er easy for all us sinners. Shoosh. I sure hope he makes the finals."

# Avengers
  robot.respond /no one needs to break anything\b/i, (msg) ->
    msg.send "Clearly you've never made an omelette."



