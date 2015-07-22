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
  robot.hear /\bdank\b/i, (message) ->
    message.send "https://i.imgur.com/bnWmD60.png"
