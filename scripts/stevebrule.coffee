# Description:
#   Steve Brule
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Steve Brule - displays a Dr. Steve Brule image from his hit show "For your health"
#
# Author:
#   Sam Wang

health = [
  "http://media.giphy.com/media/10F78PAOfsEJ0I/giphy.gif",
  "http://media.giphy.com/media/vKDHLIhIh0nMQ/giphy.gif",
  "http://25.media.tumblr.com/2029cd017551064335e9809359a95a72/tumblr_mfrtyiIywr1r8onnko1_500.png",
  "http://media.giphy.com/media/4TMqcN59kg3Yc/giphy.gif",
  "http://www.madman.com.au/images/screenshots/screenshot_1_18756.jpg",
  "http://i.imgur.com/kPOUqvJ.gif",
  "http://i.cdn.turner.com/asfix/repository//8a250aae2886f3560128880fe6b60006/thumbnail_5800043540587334846.jpg"
]

module.exports = (robot) ->
  robot.hear /steve ?brule/i, (msg) ->
    msg.send msg.random health
