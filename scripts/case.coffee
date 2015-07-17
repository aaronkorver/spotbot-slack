# Description:
#   Display case and his gunz
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot case me - Gives you case
#
# Author:
#   akorver

threshold = 0.2

module.exports = (robot) ->
  robot.respond /(case)( me)/i, (msg) ->
    random = Math.random()
    if random < threshold
      msg.send "http://i.imgur.com/cU8RzMd.png"
    else
      msg.send "(bicepleft)(case)(bicepright)"
