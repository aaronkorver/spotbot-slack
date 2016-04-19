# Description:
#   randomly gets a commit from whatthecommit.com
#
# Dependencies:
#   None
# Commands:
#   hubot commit me - Gives you a random commit from whatthecommit.com
#
# Author:
#   Rod Tan
#

# an alternative is to pull the contents of
# https://raw.githubusercontent.com/ngerakines/commitment/master/commit_messages.txt
# into memory?

commiturl="http://whatthecommit.com/index.txt"

module.exports = (robot) ->
  robot.respond /commit( me)/i, (msg) ->
    msg.http(commiturl)
      .get() (err, res, body) =>
        if err
          msg.send "Error getting commits from whatthecommit.com/index.txt"
          return
        msg.send body

