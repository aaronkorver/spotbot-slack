# Description:
#   Give, Take and List User Points
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot sparkle [person]  - Give sparkles to [person]
#   hubot unsparkle/desparkle [person]  - Remove sparkles to [person]
#   hubot rename sparkles to [name] - Renames sparkle points to something else
#   hubot sparkles top - [amount] Show top [amount] sparkle point receivers
#   hubot sparkles bottom [amount] - Show top [amount] sparkle point receivers
#   hubot report user- Shows why somebody received points
#
# Author:
#   gregcase
#
Util = require "util"

sparkles = {}
debugMode = false

debug = (msg, message) ->
  if (debugMode)
      msg.send message

room_storage = (msg) ->
    room = msg.message.room
    result = sparkles[room]
    if (!result)
        debug(msg, "creating new points for room")
        result = {pointsName: 'sparkles', tallies: []}
        sparkles[room] = result
    result

points_name = (msg) ->
    room_points = room_storage msg
    room_points['pointsName']

award_points = (msg, username, pts, reason) ->

    debug(msg, "points = #{Util.inspect(sparkles)}")

    room_points = room_storage(msg)['tallies']

    debug(msg, "room points = #{Util.inspect(room_points)}")

    room_points[username] ?= {points: 0, reasons: []}
    room_points[username]['points'] += parseInt(pts)
    if (reason?)
      room_points[username]['reasons'].push(reason)

    pointsName = points_name(msg)
    msg.send "#{username} now has #{room_points[username]['points']} #{pointsName}!"


save = (robot) ->
    robot.brain.data.sparkles = sparkles

top = (msg, amount) ->
    room_points = room_storage msg

    pointsName = points_name(msg)
    sliced = sortAndSlice(room_points.tallies, true, amount)
    if (sliced.length == 0)
      msg.send "Nobody has sparkles!"
      return

    msg.send ("Top #{sliced.length}:")
    msg.send ("========================================")
    for item in sliced
      msg.send "#{item.name} has #{item.score} #{pointsName}."

bottom = (msg, amount) ->
    room_points = room_storage msg

    pointsName = points_name(msg)
    sliced = sortAndSlice(room_points.tallies, false, amount)
    if (sliced.length == 0)
      msg.send "Nobody has sparkles!"
      return

    msg.send ("Bottom #{sliced.length}:")
    msg.send ("=======================================")
    for item in sliced
      msg.send "#{item.name} has #{item.score} #{pointsName}."


sortAndSlice = (tallies, asc = true, amount) ->
    sorted = []
    for name, obj of tallies
      sorted.push(name: name, score: obj.points)

    amount = Math.min(amount, sorted.length)
    sorted.sort((a,b) ->
      if asc then b.score - a.score else a.score - b.score).slice(0, amount)


module.exports = (robot) ->
    robot.brain.on 'loaded', ->
        points = robot.brain.data.points or {}

    robot.hear /roads/i, (msg) ->
        msg.send "Roads?  Where we're going, we don't need roads!"

    robot.respond /rename sparkles to (.*?)\s?$/i, (msg) ->
        room_points = room_storage msg
        room = msg.message.room
        room_points['pointsName'] =  msg.match[1]
        msg.send "Sparkles are now called #{msg.match[1]} in #{room}"
        save(robot)

    robot.respond /sparkle (top|bottom)( \d+)/i, (msg) ->
       amount = parseInt(msg.match[2]) || 5
       if msg.match[1] == 'top'
            top(msg, amount)
       else
            bottom(msg, amount)

    robot.respond /rename sparkles to (.*?)\s?$/i, (msg) ->
        room_points = room_storage msg
        room = msg.message.room
        room_points['pointsName'] =  msg.match[1]
        msg.send "Sparkles are now called #{msg.match[1]} in #{room}"
        save(robot)


    robot.respond /sparkle report (.*?)\s?$/i, (msg) ->
        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        room_points = room_storage(msg)['tallies']

        if (!room_points[user]?)
           msg.send "No points awarded to #{user}"
           return

        reasons = room_points[user]['reasons']
        pointsName = points_name(msg)

        msg.send "#{user} has been awarded #{room_points[user]['points']} #{pointsName}"

        if (reasons?)
           msg.send ("Let me tell you why:")
           for reason in reasons
               msg.send reason


    robot.respond /sparkle ((?!top|bottom|report).+?)( (for) (.+))?\s?$/i, (msg) ->

        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        if (msg.match[4]?)
          reason = msg.match[4].trim()
          debug(msg, "reason = #{reason}")

        msg.send "Giving 1 #{points_name(msg)} to #{user}"
        award_points(msg, user, 1, reason)
        save(robot)


    robot.respond /(?:un|de)sparkle ((?!top|bottom|report).+?)( (for) (.+))?\s?$/i, (msg) ->

        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        if (msg.match[4]?)
          reason = msg.match[4].trim()
          debug(msg, "reason = #{reason}")

        msg.send "Taking 1 #{points_name(msg)} from #{user}"
        award_points(msg, user, -1, reason)
        save(robot)
