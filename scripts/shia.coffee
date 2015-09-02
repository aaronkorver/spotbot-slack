# Description:
#   DON'T LET YOUR DREAMS BE DREAMS
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#  just do it- A random Shia will provide us with inspiration to just do it.
#
# Author:
#   SteveMin

threshold = 0.5
shias = [
  "http://media.giphy.com/media/wErJXg1tIgHXG/giphy.gif"
  "http://media.giphy.com/media/87xihBthJ1DkA/giphy.gif"
  "http://media.giphy.com/media/T1iSSDNDnk0Cs/giphy.gif"
  "http://media.giphy.com/media/1346K2lPRNQwPm/giphy.gif"
  "http://media.giphy.com/media/sEnbpoZ8ebZlK/giphy.gif"
  "http://media.giphy.com/media/HJPhN12JVDe4o/giphy.gif"
  "http://media.giphy.com/media/J7jsbfcJ2O5eo/giphy.gif"
]

module.exports = (robot) ->
  robot.hear /just do it\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "shia", threshold)
    if random < roomThreshold
      msg.send msg.random shias
