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
threshold = 1

module.exports = (robot) ->
  robot.hear /.*/i, (msg) ->
    sender = msg.message.user.mention_name.toLowerCase()
    trolls = [
        "@#{sender}, I think you forgot the (lol)"
        "@#{sender}! (yuno) use (lol)?!"
        "What?! no (lol) from @#{sender}?"
        "I thought that was worth at least one (lol).  Apprently @#{sender} lacks humor"
    ]
    random = Math.random()
    if !msg.message.text.match("\(lol\)") and sender == victim and random < threshold
      msg.send msg.random trolls
