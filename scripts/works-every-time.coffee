# Description:
#   Works every time
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   works every time - colt 45
#
# Author:
#   atmos

module.exports = (robot) ->
  robot.hear /^works every time$/i, (message) ->
    message.send "http://vnfa8y5n3zndutm1.zippykid.netdna-cdn.com/wp-content/uploads/2012/04/colt45web.jpeg"