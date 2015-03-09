# Description:
#   Welcomes a new user to the room
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   welcome `@username`
#   disown  `@username`
#
# Author:
#   therynamo


module.exports = (robot) ->
  robot.respond /(welcome)( @.*)/i ,(msg) ->
    user = msg.match[2]
    msg.send "Welcome, Lord " + user

  robot.respond /(disown)( @.*)/i ,(msg) ->
    user = msg.match[2]
    msg.send("You have been banished " + user + ", goodbye!")