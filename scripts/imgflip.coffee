# Description:
#   Creates a meme on img flip and posts the newly created meme to chat
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot meme me <meme> : <top text> / <bottom text>
#
# Author:
#   mrick

String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""

username = "spotbot"
password = "Like4Rock"

# Keep this in order, or I will find you
memeIds = {
    "aliens" : 101470
    "archer" : 10628640
    "boromir" : 61579
    "brace" : 61546
    "fry" : 61520
    "picard" : 245898
    "sohot" : 21604248
    "success" : 61544
    "wonka" : 61582
    "yuno" : 61527
    "xx" : 61532
  };

module.exports = (robot) ->
  robot.respond /(meme) me (.*):(.*)\/(.*)/i, (msg) ->

    template = memeIds[msg.match[2].strip()]
    topText = encodeURIComponent(msg.match[3].strip())
    bottomText = encodeURIComponent(msg.match[4].strip())

    if ! template?
      msg.send "I don't know that meme.  Open a pull request to add it."
      return

    url = "https://api.imgflip.com/caption_image?username=#{username}&password=#{password}&template_id=#{template}&text0=#{topText}&text1=#{bottomText}"

    msg
      .http(url)
        .get() (err, res, body) ->

          if err?
            msg.send err
            return

          msg.send JSON.parse(body)["data"]["url"]
