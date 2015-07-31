# Description:
#   Time to drop the hammer.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   enterpise hammer - drop the enterprise hammer
#   java hammer - drop the java hammer
#   spring hammer - drop the spring mvc hammer
#
# Author:
#   dak

threshold = 1

module.exports = (robot) ->
  robot.hear /enterprise hammer/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "drop-the-hammer", threshold)
    if random < roomThreshold
      msg.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/QcPuGKRGKm2Q71u/enterprise-hammer.gif"

  robot.hear /spring hammer/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "drop-the-hammer", threshold)
    if random < roomThreshold
      msg.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/huEU4xNgrxRDVNX/spring-mvc-hammer.gif"

  robot.hear /java hammer/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "drop-the-hammer", threshold)
    if random < roomThreshold
      msg.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/6drhKpChH2BWrUq/java-hammer.gif"
