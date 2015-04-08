# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   culvinize - Displays a random culvinization
#
# Author:
#   dakota.reesebrown

culviners = [
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/L5zBxiz3tKE4PyV/rogue.png"
]

module.exports = (robot) ->
  robot.hear /culvinize/i, (msg) ->
    msg.send msg.random culviners
