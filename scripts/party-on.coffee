# Description:
#   party on
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   party on hubot
#
# Author:
#   dak


module.exports = (robot) ->
  robot.hear ///party \s on \s #{robot.name}///i, (msg) ->
    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name
    msg.send "Party on, @#{sender}!"
