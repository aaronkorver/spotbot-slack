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
createMeme = require('./lib/img-flip')

String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""

templates = [8647077,44448051,44448759]
bottomText = encodeURIComponent("has no idea what they are doing".strip())

module.exports = (robot) ->

  robot.hear /^(s\/).*\//i, (msg) ->

    threshold = 0.2
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "noidea", threshold)
    if random < roomThreshold
      if msg.message.user.mention_name?
        topText = encodeURIComponent("@#{msg.message.user.mention_name.toLowerCase().strip()}")
      else
        topText = encodeURIComponent(msg.message.user.name.strip())

      createMeme(msg, "#{msg.random templates}", topText, bottomText)
