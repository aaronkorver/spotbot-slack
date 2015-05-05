# Description:
#   Trololol
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Author:
#   some jerk
#

victim = "rocky"

module.exports = (robot) ->
  robot.hear /.*/i, (msg) ->
    sender = msg.message.user.name.toLowerCase()
    random = Math.random()
    if !msg.message.text.match("\(lol\)") and sender == victim and random < 0.1
      msg.send "@#{sender}, I think you forgot the (lol)"
