# Description:
#   Revenge
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Author:
#   Another Jerk
#

victim = "alisonbeattie"
threshold = 0.25

module.exports = (robot) ->
  robot.hear /.*/i, (msg) ->
    if msg.message.user.mention_name?
      sender = msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name
    trolls = [
      "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/u5b7cVNWbFVfWTE/freedom.gif"
    ]
    random = Math.random()
    if sender == victim and random < threshold
      msg.send msg.random trolls
