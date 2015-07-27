# Description:
#   When someone corrects something, posts a I have no idea what I am doing dog
#   using their name
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_IMGFLIP_USERNAME
#   HUBOT_IMGFLIP_PASSWORD
#
# Commands:
#   None
#
# Author:
#   Rory Straubel and Jordan McGowan and thanks to Matt Rick

String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""

template = 8647077
bottomText = encodeURIComponent("has no idea what they are doing".strip())
username = process.env.HUBOT_IMGFLIP_USERNAME
password = process.env.HUBOT_IMGFLIP_PASSWORD

module.exports = (robot) ->

  unless process.env.HUBOT_IMGFLIP_USERNAME?
    robot.logger.warning "The HUBOT_IMGFLIP_USERNAME environment variable is not set"
    return false

  unless process.env.HUBOT_IMGFLIP_PASSWORD?
    robot.logger.warning "The HUBOT_IMGFLIP_PASSWORD environment variable is not set"
    return false

  robot.hear /^(s\/).*\//i, (msg) ->

    threshold = 0.2
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "noidea") || threshold
    if random < roomThreshold
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
            imgflipResponse = JSON.parse(body)
            if imgflipResponse.success == true
              msg.send imgflipResponse.data.url
            else
              msg.send "Call to imgflip.com failed: #{imgflipResponse.error_message}"
