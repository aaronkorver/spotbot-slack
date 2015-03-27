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

module.exports = (robot) ->
  robot.respond /(good night)/i, (msg) ->
    msg.send "Good night my human pet, sweet dreams"
