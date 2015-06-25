# Description:
#   The horses must be unleashed.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   unleash the horses | unleashes the horses
#
# Author:
#   dak

module.exports = (robot) ->
  robot.hear /unleash the horses\b/i, (message) ->
    message.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/6km44Pnul12Ajgj/unleash-horses.gif"