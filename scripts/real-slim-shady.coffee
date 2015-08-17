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
    xmpp_jid = msg.message.user.reply_to

    if process.env.HUBOT_HIPCHAT_TOKEN
      room_api_url = 'http://tgtbullseye.hipchat.com/v2/room'
      robot.http(room_api_url)
        .header('Accept', 'application/json')
      .query({
          auth_token: process.env.HUBOT_HIPCHAT_TOKEN
          'max-results': 1000
          'expand': 'items'
        })
      .get() (err, response, body) ->
        data = JSON.parse(body)
        rooms = data.items
        if rooms
          roomFound = false
          for room in rooms
            if room.xmpp_jid is xmpp_jid
              roomFound = true
              queryRoomForParticipants(robot, msg, room_api_url, room.id)
              break
          if ! roomFound
            robot.logger.warning "real-slim-shady no room found matching xmpp_jid #{xmpp_jid}"
            iAmSlimShady(msg)
        else
          robot.logger.warning "real-slim-shady no rooms found"
          iAmSlimShady(msg)

    else
      iAmSlimShady(msg)


queryRoomForParticipants = (robot, msg, room_api_url, room_id) ->
  url = room_api_url + '/' + room_id
  robot.logger.warning "url: #{url}"
  robot.http(url)
  .header('Accept', 'application/json')
  .query({
      auth_token: process.env.HUBOT_HIPCHAT_TOKEN
      'max-results': 1000
    })
  .get() (err, response, body) ->
    roomData = JSON.parse(body)
    users = roomData.participants
    if users
      theRealSlimShady(users, msg)
    else
      robot.logger.warning "real-slim-shady room: #{roomData}"
      for k,v of msg.envelope
        robot.logger.warning "real-slim-shady msg.envelope key : " + k + " has value " + v
      for k,v of msg.message
        robot.logger.warning "real-slim-shady msg.message key : " + k + " has value " + v
      if msg.message.user
        for k,v of msg.message.user
          robot.logger.warning "real-slim-shady msg.message.user key : " + k + " has value " + v
      iAmSlimShady(msg)


theRealSlimShady = (users, msg) ->
  slim = msg.random users

  msg.send "#{slim.name} is the real Slim Shady."

iAmSlimShady = (msg) ->
  msg.send 'I\'m the real Slim Shady. All those other Slim Shady\'s are just imitating.'
