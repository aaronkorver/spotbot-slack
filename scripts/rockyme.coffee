# Description:
#   Display Rocky in his native habitat
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot rocky me - Gives you Rocky, pure and uncut
#
# Author:
#   mrick

module.exports = (robot) ->
  robot.respond /(rocky)( me)/i, (msg) ->
    msg.send "(rocky) | (rocky) | (rocky) : You Rocky!"
