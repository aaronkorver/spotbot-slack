# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   update gradle - provides appropriate response to awesomest use of source control ever
#
# Author:
#   Curtis Schmelling

module.exports = (robot) ->
  robot.hear /update.*gradle/i, (msg) ->
    msg.send "yolo!"
