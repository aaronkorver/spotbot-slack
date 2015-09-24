# Description:
#   Makes hubot report version information to the room after hubot is restarted.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_HEROKU_API_KEY
#
# Commands:
#   hubot version - The robot reports its version to the room.
#   hubot version subscribe - The robot reports its version to the room after restarts.
#   hubot version unsubscribe - The robot no longer reports its version to the room after restarts.
#
# Author:
#   Matthew.Rick2

Log = require 'log'
{inspect} = require 'util'

@robot = undefined

logger = new Log process.env.HUBOT_LOG_LEVEL or 'info'
apiKey = process.env.HUBOT_HEROKU_API_KEY

# Makes it possible for this to work locally
defaultVersion = {
  "version": 320
  "description": "default description"
  "updated_at": "default date"
  "user": {
    "email": "default email"
  }
}

module.exports = (robot) ->

  @robot = robot

  unless apiKey?
    logger.warning "The HUBOT_HEROKU_API_KEY environment variable is not set"

  robot.brain.on 'loaded', =>
    # We need to wait to make sure we've actually entered the rooms before we
    # try to talk in them.  The Hipchat adapter doesn't really emit an
    # appropriate event for figuring that out, unfortunately.
    setTimeout(onReady.bind(this), 10 * 1000)

  robot.respond /version$/i, (msg) ->
    messageRoom(msg.message.user.reply_to, robot.brain.data.version || defaultVersion)

  robot.respond /version subscribe/i, (msg) ->
    rooms = robot.brain.data.adminRooms || []
    if (!(msg.message.user.reply_to in rooms))
      rooms.push(msg.message.user.reply_to)
      robot.brain.data.adminRooms = rooms
      msg.send "This room will now be notified of #{robot.name}'s version on restart."
    else
      msg.send "This room was already being notified of #{robot.name}'s version on restart."

  robot.respond /version unsubscribe/i, (msg) ->
    rooms = robot.brain.data.adminRooms || []
    if (msg.message.user.reply_to in rooms)
      newRooms = []
      for room in rooms
        if !(room is msg.message.user.reply_to)
          newRooms.push room
      robot.brain.data.adminRooms = newRooms
      msg.send "This room will no longer be notified of #{robot.name}'s version on restart."
    else
      msg.send "This room wasn't being notified of #{robot.name}'s version on restart."

onReady = () ->
    oldVersion = @robot.brain.data.version || defaultVersion
    @robot.http("https://api.heroku.com/apps/target-spotbot/releases")
    .header('Accept', 'application/vnd.heroku+json; version=3')
    .header('Authorization', "Bearer #{apiKey}")
    .header('Range', "version ]#{oldVersion['version']}..")
    .get() (err, response, body) ->
      rooms = @robot.brain.data.adminRooms || ['shell']
      newVersion = JSON.parse(body).pop()

      for room in rooms
        messageRoom(room, newVersion, oldVersion, "#{@robot.name} starting up...")

      if (newVersion['version'] != oldVersion['version'])
        @robot.brain.data.version = newVersion

messageRoom = (room, newVersion, oldVersion, firstLine) ->
  messageLines = []

  if (firstLine?)
    messageLines.push(firstLine)

  messageLines.push("#{@robot.name}'s version is v#{newVersion['version']}: #{newVersion['description']} (deployed by #{newVersion['user']['email']})")

  if (oldVersion? && newVersion['version'] != oldVersion['version'])
    messageLines.push("#{@robot.name}'s last start was version v#{oldVersion['version']}: #{oldVersion['description']} (deployed on #{oldVersion['updated_at']} by #{oldVersion['user']['email']})")

  @robot.messageRoom(room, messageLines.join("\n"))