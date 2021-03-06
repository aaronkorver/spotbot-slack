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
#   hubot sparkle party - sparkle everyone in the room who has been sparkled or desparkled before
#
# Author:
#   gregcase
#
Util = require "util"

class UserDetails
  constructor: ->
    @points = 0
    @reasons = new Array()


class SparkleStorage
  constructor: (@robot) ->
    @sparkles = {}

    @robot.brain.on 'loaded', =>
        @sparkles = @robot.brain.data.sparkles || {}


  roomStorage : (msg) ->
      room = msg.message.room
      result = @sparkles[room]
      if (!result)
          result = {pointsNameSingular: 'sparkle', pointsNamePlural: 'sparkles', tallies: {}}
          @sparkles[room] = result
      result

  pointsName : (msg) ->
      roomPoints = @roomStorage msg
      roomPoints['pointsNamePlural']

  pointName : (msg) ->
      roomPoints = @roomStorage msg
      roomPoints['pointsNameSingular']

  pointString : (msg, amount) ->
     if (amount == 0)
        "no #{@pointsName(msg)}"
     else if (amount == 1)
        "#{amount} #{@pointName(msg)}"
     else
        "#{amount} #{@pointsName(msg)}"

  awardPoints : (msg, username, pts, reason) ->

      roomPoints = @roomStorage(msg)['tallies']
      userDetails = @getUserDetails(msg, username)

      userDetails.points += parseInt(pts)
      if (reason?)
        userDetails.reasons.push(reason)

      lines = []
      if (pts > 0)
        lines.push "(sparkle) Awarding #{@pointString(msg, pts)} to #{username} (sparkle)"
      else
        lines.push "Taking #{@pointString(msg, Math.abs(pts))} from #{username}"
      lines.push "#{username} now has #{@pointString(msg, userDetails.points)}!"
      msg.send lines.join("\n")
      @save()

  getUserDetails : (msg, username) ->
    userDetails = @roomStorage(msg)['tallies'][username]
    if (!userDetails)
      userDetails = new UserDetails()
      @roomStorage(msg)['tallies'][username] = userDetails
    userDetails

  top : (msg, amount) ->
      roomPoints = @roomStorage msg
      @sortAndSlice(roomPoints['tallies'], true, amount)

  bottom : (msg, amount) ->
      roomPoints = @roomStorage msg
      @sortAndSlice(roomPoints['tallies'], false, amount)

  sortAndSlice : (tallies, asc = true, amount) ->
      sorted = []
      for name, obj of tallies
        sorted.push(name: name, score: obj.points)

      amount = Math.min(amount, sorted.length)
      sorted.sort((a,b) ->
        if asc then b.score - a.score else a.score - b.score).slice(0, amount)

  save : ->
      @robot.brain.data.sparkles = @sparkles

  rename : (msg, singular, plural) ->
      roomPoints = @roomStorage msg
      roomPoints['pointsNameSingular'] = singular
      roomPoints['pointsNamePlural'] =  plural
      @save()

  forget : (msg, user) ->
      delete @roomStorage(msg)['tallies'][user]
      @save()

  resetRoom : (msg) ->
    delete @roomStorage(msg)['tallies']
    @save()


module.exports = (robot) ->

    sparkleStorage = new SparkleStorage robot

    robot.respond /rename sparkles to (.*?) (.*?)\s?$/i, (msg) ->
        sparkleStorage.rename(msg, msg.match[1],  msg.match[2])
        room = msg.message.room
        msg.send "One sparkle is a \"#{sparkleStorage.pointName(msg)}\", many sparkles are called \"#{sparkleStorage.pointsName(msg)}\" in room \"#{room}\""


    robot.respond /sparkle(?:s)? (top|bottom)( \d+)?\s?$/i, (msg) ->
      amount = parseInt(msg.match[2]) || 5
      isTop = msg.match[1] == 'top';
      title =  if isTop then 'Top' else 'Bottom'
      sliced = if isTop then sparkleStorage.top(msg, amount) else sparkleStorage.bottom(msg, amount)

      lines = []
      lines.push ("#{title} #{sliced.length}:")
      lines.push ("=======================================")
      for item in sliced
        lines.push "#{item.name} has #{sparkleStorage.pointString(msg, item.score)}."

      msg.send lines.join("\n")

     
    robot.hear /performant/i, (msg)->
        user = msg.message.user.name
        reason = "\"performant\" is NOT a word!"
        sparkleStorage.awardPoints(msg, user, -1, reason)
        msg.reply "You lost a (sparkle) sparkle (sparkle) because #{reason}"    


    robot.respond /sparkle(?:s)? report (.*?)\s?$/i, (msg) ->
        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        userDetails = sparkleStorage.getUserDetails(msg, user)
        lines = []

        if (!userDetails?)
           msg.send "No #{sparkleStorage.pointsName(msg)} awarded to #{user}"
           return

        numPoints = userDetails.points
        reasons = userDetails.reasons
        pointsName = sparkleStorage.pointsName(msg)
        lines.push "(sparkle)  #{user} has been awarded #{sparkleStorage.pointString(msg, numPoints)}  (sparkle)"

        if (reasons?)
            if (reasons.length > 0)
              lines.push "Let me tell you why:"
              for reason in reasons
                lines.push reason
            else
              lines.push "I have no idea why"
        msg.send lines.join("\n")


    robot.respond /sparkle(?:s)? ((?!top|bottom|report|forget|reset|party).+?)( (for|because) (.+))?\s?$/i, (msg) ->

        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
          user = users[0]
        else
          user = msg.match[1].trim()

        #normalize to string if we have an obect from fuzzy search
        if (typeof(user) == 'object')
          user = user.mention_name || user.name

        if (msg.match[4]?)
          reason = msg.match[4].trim()

        msgFrom = msg?.message?.user?.mention_name
        if (user.substring(1) == msgFrom) #compare without the @ sign
          msg.send "OH NO YOU DIDN'T !!"
          sparkleStorage.awardPoints(msg, user, -1, "sparkling themselves")
        else
          sparkleStorage.awardPoints(msg, user, 1, reason)


    robot.respond /(?:un|de)sparkle(?:s)? (.+?)( (for|because) (.+))?\s?$/i, (msg) ->

        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        if (msg.match[4]?)
          reason = msg.match[4].trim()

        sparkleStorage.awardPoints(msg, user, -1, reason)

    robot.respond /sparkle(?:s)? forget (.*?)\s?$/i, (msg) ->
        users = robot.brain.usersForFuzzyName(msg.match[1].trim())
        if users.length is 1
            user = users[0]
        else
            user = msg.match[1].trim()

        sparkleStorage.forget(msg, user)

        msg.send "I've forgotten all about #{user}.  Never really cared for them, to tell you the truth."

    robot.respond /sparkle(?:s)? resetroom$/i, (msg) ->
       sparkleStorage.resetRoom(msg)
       msg.send "Slate has been wiped clean for room '#{msg.message.room}'"

    robot.respond /sparkle(?:s)? ?party$/i, (msg) ->
      roomData = sparkleStorage.roomStorage msg
      # GET ALL USERS (to best of ability)
      #use top, not quite as intended originally
      allUsers = sparkleStorage.top(msg, 9001) #memes
      allUsers = (user.name for user in allUsers)

      msg.send "(sparkle)(sparkle)(sparkle) #{roomData['pointsNameSingular'].toUpperCase()}" +
      " PARTY INCOMING @here! (sparkle)(sparkle)(sparkle)"

      # SPARKLE ALL USERS OBTAINED
      for user in allUsers
        sparkleStorage.awardPoints(msg, user, 1, "BECAUSE IT'S PARTY TIME")

      msg.send "(sparkle)(sparkle)(sparkle) SPARKLE PARTY OVER (sparkle)(sparkle)(sparkle)"
