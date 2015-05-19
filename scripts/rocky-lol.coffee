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

# To test locally, change #{victim} to "shell"
victim = "rocky"
threshold = 0.1

module.exports = (robot) ->
  robot.hear /.*/i, (msg) ->
    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name
    trolls = [
        "@#{sender}, I think you forgot the (lol)"
        "@#{sender}! (yuno) use (lol)?!"
        "What?! no (lol) from @#{sender}?"
        "I thought that was worth at least one (lol).  Apparently @#{sender} lacks humor"
    ]
    random = Math.random()
    if !msg.message.text.match("\(lol\)") and sender == victim and random < threshold
      msg.send msg.random trolls
