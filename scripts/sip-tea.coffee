# Description:
#   Kermit sipping tea
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   none of my business - Display a gif of kermit sipping tea
#
# Author:
#   Nick Pabon

module.exports = (robot) ->
  robot.hear /none ?of ?my ?business/i, (msg) ->
    msg.send 'http://i.imgur.com/oyjb1pd.gif'