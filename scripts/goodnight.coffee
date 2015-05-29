# Description:
#   Good Night
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   good night
#
# Author:
#  BrentNelson

goodNights = [
    "Good night my human pet, sweet dreams"
    "Sweet Dreams"
]

random = Math.random()

module.exports = (robot) ->
  robot.respond /(good night)/i, (msg) ->
    msg.send msg.random goodNights
