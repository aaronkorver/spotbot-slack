# Description:
#   Fix it, Fix it fix it fix it fix it.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   fix it
#
# Author:
#   Just fix it

module.exports = (robot) ->
  robot.hear /fix ?it\b/i, (msg) ->
    msg.send "http://media20.giphy.com/media/KqWzEMydtRHX2/giphy.gif?w=250"
