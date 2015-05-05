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
    user = msg.message.user
    for key,value of user
      msg.send key + ": " + value
