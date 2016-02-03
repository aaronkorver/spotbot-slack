# Description:
#   Hubot responds to any mention of the phrase 'help desk' or 'helpdesk'
#
# Dependencies:
#   None
#
# Configuration:
#   None
# Author:
#   Rod
#

module.exports = (robot) ->
  robot.hear /\bhelp[ ]?desk\b/i, (msg) ->
      msg.send "The Minneapolis help desk number is (612)304-4357 or the webform URL is https://target.service-now.com/ "
