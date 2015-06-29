# Description:
#   party on
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   party on spotbot
#
# Author:
#   dak

module.exports = (robot) ->
  robot.hear /party on spotbot\b/i, (message) ->
	sender = msg.message.user.mention_name.toLowerCase()
	message.send "party on @#{sender}"