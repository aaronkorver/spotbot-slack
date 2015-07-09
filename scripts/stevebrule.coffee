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
  "http://media.giphy.com/media/10F78PAOfsEJ0I/giphy.gif"
  "http://media.giphy.com/media/vKDHLIhIh0nMQ/giphy.gif"
  "http://25.media.tumblr.com/2029cd017551064335e9809359a95a72/tumblr_mfrtyiIywr1r8onnko1_500.png"
  "http://media.giphy.com/media/4TMqcN59kg3Yc/giphy.gif"
  "http://www.madman.com.au/images/screenshots/screenshot_1_18756.jpg"
  "http://i.imgur.com/kPOUqvJ.gif"
  "http://i.cdn.turner.com/asfix/repository//8a250aae2886f3560128880fe6b60006/thumbnail_5800043540587334846.jpg"
  "https://38.media.tumblr.com/91b1683d995b59b56ceb7013875858ea/tumblr_n06zujzEE41ronhn5o1_500.gif"
  "http://media.giphy.com/media/Lc9ILius61AFG/giphy.gif"
  "http://stream1.gifsoup.com/view/647056/steve-brule-cake-face-o.gif"
  "http://media.tumblr.com/tumblr_mc0734wTOz1qiplke.gif"
  "https://s-media-cache-ak0.pinimg.com/originals/68/10/89/68108919c7350dc8fd35d5130f694824.jpg"
  "http://media.giphy.com/media/zNxiyovvKj4s0/giphy.gif"
  "http://media.giphy.com/media/zRGS3PSG4NuW4/giphy.gif"
]

module.exports = (robot) ->
  robot.hear /steve ?brule/i, (msg) ->
    msg.send msg.random health
