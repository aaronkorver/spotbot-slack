# Description:
#   POCKET SAND
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   pocket sand - displays the pocket sand gif
#
# Author:
#   Nick Pabon


module.exports = (robot) ->
  robot.hear /pocket ?sand/i, (msg) ->
    msg.send 'http://i.imgur.com/cMzI6gu.gif'