# Description:
#   For when stuff is fubar
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot dumpster fire - displays dumpster fire
#
# Author:
#   AlexWolf

module.exports = (robot) ->
  robot.respond /dumpster ?fire/i, (message) ->
    message.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/2336124/f9VF0juPpCX5cu2/dumpster.gif"
