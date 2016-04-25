# Description:
#   randomly gets a commit from whatthecommit.com
#
# Dependencies:
#   None
#
# Commands:
#   hubot commit me - Gives you a random commit from whatthecommit.com
#
# Author:
#   Rod Tan
#

commiturl="http://whatthecommit.com/index.txt"

module.exports = (robot) ->
  robot.respond /commit( me)/i, (msg) ->
    random = Math.random()
    if random < 0.4
      msg.send 'update build.gradle'
    else
      msg.http(commiturl)
        .get() (err, res, body) =>
          if err
            msg.send "Error getting commits from whatthecommit.com/index.txt"
            return
          msg.send body
