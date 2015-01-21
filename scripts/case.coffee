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


module.exports = (robot) ->
  robot.respond /(case)( me)/i, (msg) ->
    msg.send "(bicepleft)(case)(bicepright)"
