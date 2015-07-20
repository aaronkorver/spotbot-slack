# Description:
#   Decide who the real Slim Shady is once and for all.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot who's the real slim shady? - Picks a user in the room to declare as the real Slim Shady
#
# Author:
#   Matthew Dordal

module.exports = (robot) ->

  robot.respond /who's the real Slim Shady\?/i, (msg) ->
    room = msg.envelope.room

    if process.env.HUBOT_HIPCHAT_TOKEN
      robot.http('https://api.hipchat.com/v2/room/' + room)
        .header('Accept', 'applicaiton/json')
        .query({
          auth_token: process.env.HUBOT_HIPCHAT_TOKEN
          'max-results': 1000
        })
        .get() (err, response, body) ->
          data = JSON.parse(body)
          users = data.participants
          theRealSlimShady(users, msg)
    else
      msg.send 'I\'m the real Slim Shady. All those other Slim Shady\'s are just imitating.'

theRealSlimShady = (users, msg) ->
  slim = msg.random users

  msg.send "#{slim.name} is the real Slim Shady."
