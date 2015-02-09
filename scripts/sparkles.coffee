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
#   hubot rename sparkles to [singular] [plural] - Renames sparkle points to something else
#   hubot sparkle top - [amount] Show top [amount] sparkle point receivers
#   hubot sparkle bottom [amount] - Show bottom [amount] sparkle point receivers
#   hubot sparkle report [user] - Shows why somebody received points
#   hubot sparkle forget [user] - Tell hubot to forget about somebody in a room
#
# Author:
#   gregcase
#
Util = require "util"

@sparkles = {}
debugMode = false


debug = (msg, message) ->
  if (debugMode)
      console.log msg

room_storage = (msg) ->
    room = msg.message.room
    result = @sparkles[room]
    if (!result)
        debug(msg, "creating new points for room")
        result = {pointsNameSingular: 'sparkle', pointsNamePlural: 'sparkles', tallies: []}
        @sparkles[room] = result
    result

points_name = (msg) ->
    room_points = room_storage msg
    room_points['pointsNamePlural']

point_name = (msg) ->
    room_points = room_storage msg
    room_points['pointsNameSingular']

point_string = (msg, amount) ->
   if (amount == 0)
      "no #{points_name(msg)}"
   if (amount == 1)
      "#{amount} #{point_name(msg)}"
   else
      "#{amount} #{points_name(msg)}"

award_points = (msg, username, pts, reason) ->

    room_points = room_storage(msg)['tallies']

    debug(msg, "room points = #{Util.inspect(room_points)}")

    room_points[username] ?= {points: 0, reasons: []}
    room_points[username]['points'] += parseInt(pts)
    if (reason?)
      room_points[username]['reasons'].push(reason)

    lines = []
    num_points = room_points[username]['points']
    if (pts > 0)
      lines.push "Awarding #{point_string(msg, pts)} to #{username}"
    else
      lines.push "Taking #{point_string(msg, pts)} to #{username}"
    lines.push "#{username} now has #{point_string(msg, num_points)}!"
    msg.send lines.join("\n")

save = (robot) ->
    robot.brain.data.sparkles = sparkles

top = (msg, amount) ->
    room_points = room_storage msg

    pointsName = points_name(msg)
    sliced = sortAndSlice(room_points.tallies, true, amount)
    if (sliced.length == 0)
      msg.send "Nobody has any #{points_name(msg)}!"
      return

    lines = []
    lines.push ("Top #{sliced.length}:")
    lines.push ("=======================================")
    for item in sliced
      lines.push "#{item.name} has #{point_string(msg, item.score)}."

    msg.send lines.join("\n")

bottom = (msg, amount) ->
    room_points = room_storage msg

    pointsName = points_name(msg)
    sliced = sortAndSlice(room_points.tallies, false, amount)
    if (sliced.length == 0)
      msg.send "Nobody has any #{points_name(msg)}!"
      return

    lines = []
    lines.push ("Bottom #{sliced.length}:")
    lines.push ("=======================================")
    for item in sliced
      lines.push "#{item.name} has #{point_string(msg, item.score)}."

    msg.send lines.join("\n")

sortAndSlice = (tallies, asc = true, amount) ->
    sorted = []
    for name, obj of tallies
      sorted.push(name: name, score: obj.points)

    amount = Math.min(amount, sorted.length)
    sorted.sort((a,b) ->
      if asc then b.score - a.score else a.score - b.score).slice(0, amount)


module.exports = (robot) ->
    robot.brain.on 'loaded', ->
        console.log "Loading sparkles from brain"
        @sparkles = robot.brain.data.sparkles or {}

    robot.hear /roads/i, (msg) ->
        msg.send "Roads?  Where we're going, we don't need roads!"

    robot.respond /rename sparkles to (.*?) (.*?)\s?$/i, (msg) ->
        room_points = room_storage msg
        room = msg.message.room
        room_points['pointsNameSingular'] =  msg.match[1]
        room_points['pointsNamePlural'] =  msg.match[2]
        msg.send "One sparkle is a \"#{point_name(msg)}\", many sparkles are called \"#{points_name(msg)}\" in room \"#{room}\""
        save(robot)

    robot.respond /sparkle(?:s)? (top|bottom)( \d+)?\s?$/i, (msg) ->
       amount = parseInt(msg.match[2]) || 5
       if msg.match[1] == 'top'
            top(msg, amount)
       else
            bottom(msg, amount)

    robot.respond /sparkle(?:s)? report (.*?)\s?$/i, (msg) ->
        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        room_points = room_storage(msg)['tallies']

        lines = []

        if (!room_points[user]?)
           msg.send "No #{points_name(msg)} awarded to #{user}"
           return

        reasons = room_points[user]['reasons']
        pointsName = points_name(msg)
        num_points = room_points[user]['points']
        lines.push "#{user} has been awarded #{point_string(msg, num_points)}"

        if (reasons?)
           lines.push "Let me tell you why:"
           for reason in reasons
               lines.push reason

        msg.send lines.join("\n")


    robot.respond /sparkle(?:s)? ((?!top|bottom|report|forget).+?)( (for) (.+))?\s?$/i, (msg) ->

        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        if (msg.match[4]?)
          reason = msg.match[4].trim()
          debug(msg, "reason = #{reason}")

        award_points(msg, user, 1, reason)
        save(robot)


    robot.respond /(?:un|de)sparkle(?:s)? (.+?)( (for) (.+))?\s?$/i, (msg) ->

        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        if (msg.match[4]?)
          reason = msg.match[4].trim()
          debug(msg, "reason = #{reason}")

        award_points(msg, user, -1, reason)
        save(robot)

    robot.respond /sparkle(?:s)? forget (.*?)\s?$/i, (msg) ->
        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        room_points = room_storage(msg)['tallies']
        delete room_points[user]

        msg.send "I've forgotten all about #{user}.  Never really cared for them, to tell you the truth."
