# Description:
#   Listens for hubot shame and responds with a GIF of the "Shame Nun" from Game of Thrones.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot shame - displays the GoT shame nun
#
# Author:
#   GradyJohnson

shame = "http://i.imgur.com/LbrPKu1.gifv"

module.exports = (robot) ->
  robot.respond /shame\b/i, (message) ->
    message.send shame
