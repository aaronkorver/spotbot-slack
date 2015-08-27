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

Log = require 'log'

username = process.env.HUBOT_IMGFLIP_USERNAME
password = process.env.HUBOT_IMGFLIP_PASSWORD

logger = new Log process.env.HUBOT_LOG_LEVEL or 'info'

module.exports = (msg, template, topText, bottomText) ->

    unless process.env.HUBOT_IMGFLIP_USERNAME? && process.env.HUBOT_IMGFLIP_PASSWORD?
      msg.reply "HUBOT_IMGFLIP_USERNAME and/or HUBOT_IMGFLIP_PASSWORD have not been set.  Contact your admin to set them."
      return

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

unless process.env.HUBOT_IMGFLIP_USERNAME?
  logger.warning "The HUBOT_IMGFLIP_USERNAME environment variable is not set"

unless process.env.HUBOT_IMGFLIP_PASSWORD?
  logger.warning "The HUBOT_IMGFLIP_PASSWORD environment variable is not set"
