# Description:
#   I WANT COFFEE
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot coffee-time
#
# Author:
#   therynamo
#

module.exports = (robot) ->
  robot.respond /(coffee)(time)?/i, (msg) ->
    msg.send 'https://s3.amazonaws.com/uploads.hipchat.com/171096/1611704/ryhIlFkfCgzwJe7/coffee-time.gif'
