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

takeouts= [
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/2273427/BVsFp5evMCtERD4/rko1.jpg"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/2273427/wr4ViWNR8PKb5va/rko4.jpeg"
 "https://s3.amazonaws.com/uploads.hipchat.com/171096/2273427/CrFtv5WHIGB3VS0/rko5.jpg"
 "http://giphy.com/gifs/mxCDwAKIGAbug/html5"
 "http://giphy.com/gifs/cNS8AM28CJ7e8/html5"

]


module.exports = (robot) ->
  robot.hear /outta nowhere/i, (message) ->
    message.send message.random takeouts
