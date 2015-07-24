# Description:
#   RKO - Randall Keith "Randy" Orton taking people out outta nowhere
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   outta nowhere - Displays RKO gif outta nowhere
#
# Author:
#   Peyton Zeller-Av

threshold = 1
takeouts= [
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/2273427/BVsFp5evMCtERD4/rko1.jpg"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/2273427/wr4ViWNR8PKb5va/rko4.jpeg"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/2273427/CrFtv5WHIGB3VS0/rko5.jpg"
]


module.exports = (robot) ->
  robot.hear /outta nowhere/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "rko") || threshold
    if random < roomThreshold
      message.send message.random takeouts
