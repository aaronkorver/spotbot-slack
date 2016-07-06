# Description:
#   Nicolas Cage and all of His glory.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot nick cage - your favorite images of nick cage
#
# Author:
#   MichaelBlack2


nicolas = [
  "http://i.imgur.com/dzVAh.jpg"
  "http://i.imgur.com/qviVh.jpg"
  "http://i.imgur.com/ajjJz.jpg"
  "http://i.imgur.com/JonOK.jpg"
  "http://i.imgur.com/zE8Y8.jpg"
  "http://i.imgur.com/VrlnO.jpg"
  "http://i.imgur.com/FrxUs.jpg"
  "http://i.imgur.com/nePpz.jpg"
  "http://i.imgur.com/Jg8uF.jpg"
  "http://i.imgur.com/BvkCd.jpg"
  "http://i.imgur.com/A3w73eh.jpg"
  "http://i.imgur.com/rOrsr5S.jpg"
  "http://i.imgur.com/YdT97kh.jpg"
  "http://i.imgur.com/spYh4MZ.jpg"
  "http://i.imgur.com/21DTtdG.jpg"
  "http://i.imgur.com/FETfvF3.jpg"
  "http://i.imgur.com/fQBUbEU.jpg"
  "http://i.imgur.com/uFLEmKn.jpg"
  "http://i.imgur.com/J2sCLTF.jpg"
  "http://i.imgur.com/ZhctqLN.jpg"
  "http://i.imgur.com/j43h9Jn.png"
  "http://i.imgur.com/KflwjDn.png"
  "http://i.imgur.com/2euUi5N.png"
  "http://i.imgur.com/KK6vzuG.png"
  "http://i.imgur.com/YND13G5.png"
  "http://i.imgur.com/8Uqsc1j.png"
  "http://i.imgur.com/8HJgWpu.png"
  "http://i.imgur.com/eotwds2.jpg"
  "http://i.imgur.com/bx2xg9w.jpg"
  "http://i.imgur.com/GdmtBgv.png"
  "http://i.imgur.com/Zl9PDKW.png"
  "http://i.imgur.com/bLNBnn7.png"
  "http://i.imgur.com/sX3GzNN.png"
  "http://i.imgur.com/EV7j3ot.png"
  "http://i.imgur.com/w7BjiHc.png"
  "http://i.imgur.com/yQTY98F.jpg"
  "http://i.imgur.com/2wWQA9f.png"
  "http://i.imgur.com/VAmmVob.png"
  "http://i.imgur.com/WIhue4H.png"
  "http://i.imgur.com/7oelF3O.png"
  "https://media.giphy.com/media/TR95rSgPsHqiQ/giphy.gif"
]

module.exports = (robot) ->
  robot.respond /(nick|nic|nicolas|nicholas) ?cage/i, (message) ->
    message.send message.random nicolas
