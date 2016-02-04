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
#   hubot desk 
# Author:
#   Rod
#
helpdesk_msg = "The Minneapolis help desk number is (612)304-4357 or the webform URL is https://target.service-now.com/"
module.exports = (robot) ->
  robot.respond /desk/i, (msg) ->
      msg.send helpdesk_msg
  robot.hear /\bhelp[ ]?desk\b/i, (msg) ->
      msg.send helpdesk_msg
