# Description:
#   WUBBA LUBBA DUB DUB
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   WLDD
#
# Author:
#   Nick Pabon

module.exports = (robot) ->
  robot.hear /works every time/i, (message) ->
    message.send "http://ih0.redbubble.net/image.104525267.7495/flat,1000x1000,075,f.jpg"
