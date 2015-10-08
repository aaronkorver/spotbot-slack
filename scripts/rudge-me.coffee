# Description:
#   Call down mighty rudgement on the impure
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot rudge me top-text / bottom-text -
#
# Author:
#   mrick

createMeme = require('./lib/img-flip')

module.exports = (robot) ->
  
  robot.respond /rudge me (.*)\/(.*)/i, (msg) ->

    topText = msg.match[1].strip()
    bottomText = msg.match[2].strip()

    createMeme(msg, 47438694, topText, bottomText)
