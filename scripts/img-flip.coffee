# Description:
#   Creates a meme on img flip and posts the newly created meme to chat
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_IMGFLIP_USERNAME
#   HUBOT_IMGFLIP_PASSWORD
#
# Author:
#   mrick

username = process.env.HUBOT_IMGFLIP_USERNAME
password = process.env.HUBOT_IMGFLIP_PASSWORD

unless process.env.HUBOT_IMGFLIP_USERNAME?
  robot.logger.warning "The HUBOT_IMGFLIP_USERNAME environment variable is not set"
  return false

unless process.env.HUBOT_IMGFLIP_PASSWORD?
  robot.logger.warning "The HUBOT_IMGFLIP_PASSWORD environment variable is not set"
  return false

module.exports =

  (msg, template, topText, bottomText) ->
    console.log("#{template}, #{topText}, #{bottomText}")
    url = "https://api.imgflip.com/caption_image?username=#{username}&password=#{password}&template_id=#{template}&text0=#{topText}&text1=#{bottomText}"
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
