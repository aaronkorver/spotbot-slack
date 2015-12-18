# Description:
#   *Chirp* *Chirp* No one's home
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   Matthew.Rick2

threshold = 0.0
crickets = [
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531208/MVJAzWHJl4iZ8KR/insect_musicians_gryllus-_ruben_WH_WHITE1.jpg'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531208/zY59q9jCT6eDXnC/10809719-Cricket-playing-the-guitar-Stock-Vector-insect.jpg'
  'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531208/I2FkkcAwGncLS3q/latest.jpg'
]

module.exports = (robot) ->
  robot.hear /\bcrickets\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "crickets", threshold)
    if random < roomThreshold
      msg.send msg.random crickets
