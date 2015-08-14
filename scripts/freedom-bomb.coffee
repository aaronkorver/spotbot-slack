# Description:
#   FREEDOM!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot freedom bomb => unleashes freedome

# Author:
#   Dak for AlisonBeattie

module.exports = (robot) ->
    robot.respond /freedom bomb/i, (msg) ->
        msg.send("https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/Hn5n5VbJo4fRbQx/freedom.gif") for num in [1..7]