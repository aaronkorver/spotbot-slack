# Description:
#   Clearly illustrate with an image what people mean whenever they say "wtf"
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   wtf
#
# Author:
#   arudge

module.exports = (robot) ->
  robot.hear /wtf\b/i, (message) ->
    message.send "http://i.imgur.com/P2vkwAS.gif"