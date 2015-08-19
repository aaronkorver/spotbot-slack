# Description:
#   When someone corrects something, posts a I have no idea what I am doing dog
#   using their name
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_IMGFLIP_USERNAME
#   HUBOT_IMGFLIP_PASSWORD
#
# Commands:
#   None
#
# Author:
#   Rory Straubel and Jordan McGowan and thanks to Matt Rick

Util = require "util"
createMeme = require('./img-flip')

String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""

template = 8647077
bottomText = encodeURIComponent("has no idea what they are doing".strip())

module.exports = (robot) ->

  robot.hear /^(s\/).*\//i, (msg) ->

    threshold = 0.2
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "noidea", threshold)
    if random < roomThreshold
      if msg.message.user.mention_name?
        sender =  encodeURIComponent("@#{msg.message.user.mention_name.toLowerCase().strip()}")
      else
        sender = encodeURIComponent(msg.message.user.name.strip())

      createMeme(msg, template, topText, bottomText)
