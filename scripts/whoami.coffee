# Description:
#   Gets your actual username
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Author:
#   Mr. Ick
#

module.exports = (robot) ->
  robot.respond /who[ ]?am[ ]?i/i, (msg) ->
    msg.send msg.message.user.name
