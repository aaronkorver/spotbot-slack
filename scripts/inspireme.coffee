# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   inspire me - Display a follow your dreams sloth gif.
#
# Author:
#   April Ai (Sichun)

module.exports = (robot) ->
  robot.hear /inspire me\b/i, (msg) ->
    msg.send "http://i.imgur.com/tNkzm5e.gif"
