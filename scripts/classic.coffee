# Description:
#   Listens for hubot classic and responds with "classic" image from the hangover
#   if instead hubot hears "classic katrina" the katrina face varient is instead posted

# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot classic - displays a classic image
#
# Author:
#   John O'Brien



module.exports = (robot) ->
  robot.respond /classic(?! katrina)\b/i, (message) ->
    message.send "http://cdn.meme.am/instances/64205409.jpg"


  robot.respond /classic katrina\b/i, (message) ->
    message.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/2336124/E3qilzj6nRw7xQr/classic2.jpg"
