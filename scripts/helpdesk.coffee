# Description:
#   Hubot responds to any mention of the phrase 'help desk' or 'helpdesk'
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot desk - Prints out the helpdesk number (612)304-4357 and the url (https://target.service-now.com) 
# Author:
#   Rod
#
helpdesk_msg = "The Minneapolis help desk number is (612)304-4357 or the webform URL is https://target.service-now.com/"

threshold = 0.35

module.exports = (robot) ->
  robot.respond /desk/i, (msg) ->
      msg.send helpdesk_msg
  robot.hear /\bhelp[ ]?desk\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "vendor", threshold)
    if random < roomThreshold
      msg.send helpdesk_msg
