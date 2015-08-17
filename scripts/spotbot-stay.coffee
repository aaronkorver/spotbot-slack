# Description:
#   Makes hubot stay in a room after hubot is restarted.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot stay - The robot rejoins the room after restarts.
#   hubot don't stay - The robot no longer joins the room after restarts.
#   hubot list rooms - Lists the rooms the robot joins after restarts.
#
# Author:
#   Matthew.Rick2 (the evil twin!!!1!!)

Util = require "util"
rooms = []

module.exports = (robot) ->

  robot.brain.on 'loaded', =>
    rooms = robot.brain.data.rooms || {}
    for room in rooms
      robot.joinRoom(room)

  robot.respond /stay$/i, (msg) ->
    rooms.push msg.message.user.replyTo
    robot.brain.data.rooms = rooms
    msg.send "Woof!"

  robot.respond /do(n't| not) stay$/i, (msg) ->
    response = "#{getRobotName()} did not automatically join this room."
    banishingRoom = msg.message.user.replyTo
    newRooms = []
    for room in rooms
      if ! room is banishingRoom
        newRooms.push room
      else
        response = "#{getRobotName()} will no longer join this room automatically."
    robot.brain.data.rooms = newRooms
    msg.send response

  robot.respond /list rooms$/i, (msg) ->
    response = "#{getRobotName()} doesn't join any rooms automatically."
    if rooms.length
      lines = ["#{getRobotName()} joins these rooms on restart:"]
      for room in rooms
        lines.push "\t#{room}"
      response = lines.join("\n")
    msg.send response

  getRobotName = ->
    robot.name.charAt(0).toUpperCase() + robot.name.slice(1)
