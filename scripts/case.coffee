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

  cases = [
    "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/7PYohL39KqHeglc/animated.gif"
    "https://s3.amazonaws.com/uploads.hipchat.com/171096/1531535/x1TM3MVqOMyE2qn/case-small.png"
    "(bicepleft)(case)(bicepright)"
  ]

  robot.respond /(case)( me)/i, (msg) ->
    msg.send (msg.random cases)
