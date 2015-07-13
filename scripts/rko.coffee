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
#   outta nowhere
#
# Author:
#   Peyton Zeller-Av

takeouts= [
 "http://memecrunch.com/meme/AT8P/rko/image.jpg"
 "http://giphy.com/gifs/mxCDwAKIGAbug/html5"
 "http://giphy.com/gifs/cNS8AM28CJ7e8/html5"
 "http://i1.kym-cdn.com/entries/icons/original/000/016/651/QxVGoySI_400x400.jpeg"
 "https://s-media-cache-ak0.pinimg.com/originals/57/62/1a/57621af289b4394af73a51ee38f14c69.jpg"

]


module.exports = (robot) ->
  robot.hear /outta nowhere/i, (message) ->
    message.send message.random takeouts
