# Description:
#   Needs no description.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   arudge

module.exports = (robot) ->
  robot.hear /aw+\s?yis+\b/i, (message) ->
    message.send "http://i.imgur.com/2roh9QL.gif"