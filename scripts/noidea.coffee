# Description:
#   When someone corrects something, posts a I have no idea what I am doing dog
#   using their name
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
#   Rory Straubel and Jordan McGowan and thanks to Matt Rick

String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""

username = "spotbot"
password = "Like4Rock"
template = 8647077
bottomText = encodeURIComponent("has no idea what they are doing".strip())

module.exports = (robot) ->

  robot.hear /(s\/).*/i, (msg) ->

    threshold = 0.2
    random = Math.random()
    if threshold>random

      if msg.message.user.mention_name?
        sender =  encodeURIComponent(msg.message.user.mention_name.toLowerCase().strip())
      else
        sender = encodeURIComponent(msg.message.user.name.strip())

        url = "https://api.imgflip.com/caption_image?username=#{username}&password=#{password}&template_id=#{template}&text0=#{sender}&text1=#{bottomText}"

      msg
        .http(url)
          .get() (err, res, body) ->
            if err
              msg.send "Encountered an error: #{err}"
              return
            else
              msg.send JSON.parse(body)["data"]["url"]
