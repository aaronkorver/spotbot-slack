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
    room_id = msg.message.data.room_id

    if process.env.HUBOT_HIPCHAT_TOKEN
      url = 'http://tgtbullseye.hipchat.com/v2/room/' + room_id
      robot.logger.warning "url: #{url}"
      robot.http(url)
        .header('Accept', 'application/json')
        .query({
          auth_token: process.env.HUBOT_HIPCHAT_TOKEN
          'max-results': 1000
        })
        .get() (err, response, body) ->
          data = JSON.parse(body)
          users = data.participants
          if users
            theRealSlimShady(users, msg)
          else
            robot.logger.warning "real-slim-shady room: #{room}"
            robot.logger.warning "real-slim-shady room_id: #{room_id}"
            robot.logger.warning "real-slim-shady token: #{process.env.HUBOT_HIPCHAT_TOKEN}"
            robot.logger.warning "real-slim-shady error: #{err}"
            robot.logger.warning "real-slim-shady response: #{response}"
            robot.logger.warning "real-slim-shady body: #{body}"
            for k,v of msg.envelope
              robot.logger.warning "real-slim-shady msg.envelope key : " + k + " has value " + v
            for k,v of msg.message
              robot.logger.warning "real-slim-shady msg.message key : " + k + " has value " + v
            if msg.message.user
              for k,v of msg.message.user
                robot.logger.warning "real-slim-shady msg.message.user key : " + k + " has value " + v
            iAmSlimShady(msg)
    else
      iAmSlimShady(msg)

theRealSlimShady = (users, msg) ->
  slim = msg.random users

  msg.send "#{slim.name} is the real Slim Shady."

iAmSlimShady = (msg) ->
  msg.send 'I\'m the real Slim Shady. All those other Slim Shady\'s are just imitating.'
