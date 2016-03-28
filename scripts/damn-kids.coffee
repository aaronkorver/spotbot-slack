# Description:
#   Spotbot will attempt to keep the damn kids off your lawn.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Author:
#   KevinBehrens
#

# To test locally, change #{victim} to "Shell"
victim = "jeff"
threshold = 0

threats = [
    "@#{victim}, Get off my lawn."
    "Get off my lawn, @#{victim}."
    "Hey! you! Kid! get off my lawn, @#{victim}!"
    "Kids these days! GET OFF MY LAWN, @#{victim}!"
]

module.exports = (robot) ->

  robot.hear /.*/i, (msg) ->

    roomThreshold = robot.thresholdStorage.getThreshold(msg, "damn-kids", threshold)

    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name

    random = Math.random()
    if  sender == victim and random < roomThreshold
      msg.send msg.random threats
