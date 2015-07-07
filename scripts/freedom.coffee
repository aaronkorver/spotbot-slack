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
    sender = msg.message.user.mention_name.toLowerCase()
    trolls = [
      "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/u5b7cVNWbFVfWTE/freedom.gif"
    ]
    random = Math.random()
    if sender == victim and random < threshold
      msg.send msg.random trolls
