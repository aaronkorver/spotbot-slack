# Description:
#   Random Chris Farley gifs
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   farley - summons a farley gif
#
# Author:
#   nicholasmaki


farley = [
  "http://replygif.net/i/1078.gif"
  "http://replygif.net/i/1378.gif"
  "http://media.giphy.com/media/MJHwNAWicW9zO/giphy.gif"
  "http://media.giphy.com/media/iVe09NV82gm1a/giphy.gif"
  "http://media.giphy.com/media/MfUYQKRmIVZzq/giphy.gif"
  "http://media.giphy.com/media/bPTXcJiIzzWz6/giphy.gif"
]

module.exports = (robot) ->
  robot.respond /farley/i, (message) ->
    message.send message.random farley
