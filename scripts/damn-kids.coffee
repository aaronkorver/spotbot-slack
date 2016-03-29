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

# To test locally, change #{kid} to "Shell"
kid = "jeff"
threshold = 0

threats = [
    "@#{kid}, Get off my lawn."
    "Get off my lawn, @#{kid}."
    "Hey! you! Kid! get off my lawn, @#{kid}!"
    "Kids these days! GET OFF MY LAWN, @#{kid}!"
]

module.exports = (robot) ->

  robot.hear /.*/i, (msg) ->

    roomThreshold = robot.thresholdStorage.getThreshold(msg, "damn-kids", threshold)

    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase().trim()
    else
      sender = msg.message.user.name.trim()

    random = Math.random()
    if  sender == kid and random < roomThreshold
      msg.send msg.random threats
