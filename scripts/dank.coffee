# Description:
#   We're all explorers
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   dank - Has anyone ever really been so far?
#
# Author:
#   Greyson Dehn

module.exports = (robot) ->
  robot.hear /(\b|#)dank(\b)/i, (message) ->
    message.send "https://i.imgur.com/bnWmD60.png"
