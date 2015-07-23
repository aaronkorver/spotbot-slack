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

# To test locally, change #{victim} to "Shell"
victim = "rocky"
threshold = 0.1

trolls = [
    "@#{victim}, I think you forgot the (lol)"
    "@#{victim}! (yuno) use (lol)?!"
    "What?! no (lol) from @#{victim}?"
    "I thought that was worth at least one (lol).  Apparently @#{victim} lacks humor"
]

module.exports = (robot) ->

  robot.hear /.*/i, (msg) ->

    roomThreshold = robot.thresholdStorage.getThreshold(msg, "rocky-lol") || threshold

    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name

    random = Math.random()
    if !msg.message.text.match("\(lol\)") and sender == victim and random < roomThreshold
      msg.send msg.random trolls
