# Description:
#   Kindly do the needful...
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot do the needful => reminds user to say kindly
#   hubot kindly do the needful => the needful gets done

# Author:
#   dak

needfuls = [
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/FKN1thMroiglYdc/cant-handle-the-needful.png"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/iOar5bFqn3R0NsV/failure.png"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/FX2T8ALcfTW6OYk/houston.png"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/slJWsw5nLtQuOgA/minions-needful.png"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/o3wiSv18Gx2reen/needful-is.png"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/YkLezRC2W0OVCxp/show-me-the-needful.png"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/UnPHEhhWISgzMiY/the-need-for-needful.png"
]

module.exports = (robot) ->
    robot.respond /do the needful/i, (msg) ->
        msg.reply("You didn't say 'kindly.'")
    
    robot.respond /kindly do the needful/i, (msg) ->
        random = Math.random()
        msg.reply msg.random needfuls

