# Description:
#   Hubot responds to any mention of the word train
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Anyone ready for the lunch train?
#   Choo! Choo!
#

module.exports = (robot) ->
  robot.hear /\btrain\b/i, (msg) ->
    msg.send "Choo! Choo!"
