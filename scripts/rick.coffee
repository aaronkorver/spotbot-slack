# Description:
#   Display rick and his (lack of) gunz
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot rick me - Gives you rick
#
# Author:
#   akorver


module.exports = (robot) ->
  robot.respond /(rick)( me)/i, (msg) ->
    msg.send "(skinnyarmleft)(rageguy)(skinnyarmright)"
