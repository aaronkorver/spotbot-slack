# Description:
#   Hubot responds to any mention of the word vendor
#
# Dependencies:
#   None
#
# Configuration:
#   None
#

module.exports = (robot) ->
  robot.hear /\bvendor\b/i, (msg) ->
    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name
    msg.send "@#{sender}, I think you meant 'Strategic Partners'"
