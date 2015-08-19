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

class XmppJidToRoomIdMapping
  constructor: (@robot) ->
    @xmppJidToRoomIdMapping = {}

    @robot.brain.on 'loaded', =>
      @xmppJidToRoomIdMapping = @robot.brain.data.xmppJidToRoomIdMapping || {}

  getRoomIdFromXmppJid : (xmppJid) ->
    @xmppJidToRoomIdMapping[xmppJid]

  setRoomIdForXmppJid : (xmppJid, roomId) ->
    @xmppJidToRoomIdMapping[xmppJid] = roomId

  getXmppJidToRoomIdMapping : ->
    @xmppJidToRoomIdMapping

  clear : ->
    @xmppJidToRoomIdMapping = {}

  save : ->
    @robot.brain.data.xmppJidToRoomIdMapping = @xmppJidToRoomIdMapping

module.exports = (robot) ->

  robot.respond /who's the real Slim Shady\?/i, (msg) ->
    xmpp_jid = msg.message.user.reply_to
    room_api_url = 'http://tgtbullseye.hipchat.com/v2/room'
    mapping = new XmppJidToRoomIdMapping robot
    room_id = mapping.getRoomIdFromXmppJid(xmpp_jid)

    if process.env.HUBOT_HIPCHAT_TOKEN
      if room_id
        queryRoomForParticipants(robot, msg, room_api_url, room_id)
      else
        generateNewMapAndQueryRoomForParticipants(robot, msg, room_api_url, xmpp_jid, mapping)

    else
      iAmSlimShady(msg)


generateNewMapAndQueryRoomForParticipants = (robot, msg, room_api_url, xmpp_jid, mapping) ->
  mapping.clear()
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

      room_id = null
      for room in rooms
        robot.logger.warning "real-slim-shady about to push #{room.id} for #{room.xmpp_jid}"
        mapping.setRoomIdForXmppJid(room.xmpp_jid, room.id)
        if room.xmpp_jid is xmpp_jid
          room_id = room.id

      robot.logger.warning "real-slim-shady about to save the final map:"
      robot.logger.warning mapping.getXmppJidToRoomIdMapping()
      mapping.save()

      if room_id
        queryRoomForParticipants(robot, msg, room_api_url, room_id)
      else
        robot.logger.warning "real-slim-shady no room found matching xmpp_jid #{xmpp_jid}"
        iAmSlimShady(msg)

    else
      robot.logger.warning "real-slim-shady no rooms found"
      iAmSlimShady(msg)


queryRoomForParticipants = (robot, msg, room_api_url, room_id) ->
  url = room_api_url + '/' + room_id
  robot.logger.warning "real-slim-shady url: #{url}"
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
