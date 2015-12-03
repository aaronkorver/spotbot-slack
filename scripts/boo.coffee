# Description:
#   Listens for hubot booo and responds with a GIF of the booing dream townswoman from Game of The Princess Bride.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot booo - displays the The Princess Bride booing dream townswoman
#
# Author:
#   JoeyRoss

threshold = .01

booGifs = [
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/2341798/MtKyzw8RdnYyZBD/BooBoo.gif"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/2341798/MAKJ82i3dJis06Q/boooooo.gif"
]

module.exports = (robot) ->
  robot.hear /\bbo{3,}\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "booo", threshold)
    if random < roomThreshold
      msg.send msg.random booGifs

