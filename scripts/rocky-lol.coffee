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
threshold = 0.1

module.exports = (robot) ->
  robot.hear /.*/i, (msg) ->
    sender = msg.message.user.name.toLowerCase()
    random = Math.random()
    if !msg.message.text.match("\(lol\)") and sender == victim and random < threshold
      msg.send "@#{sender}, I think you forgot the (lol)"
