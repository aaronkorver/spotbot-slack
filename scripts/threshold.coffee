# Description:
#   Creates a simple interface for setting and getting room specific thresholds.
#   This is intended to be used by other scripts to make persisting room
#   specific thresholds for robot.hear scripts simple and consistent.
#
# Example usage (for foo.coffee):
#   threshold = 0.1
#   roomThreshold = robot.thresholdStorage.getThreshold(msg, "foo", threshold)
#   if Math.random > roomThreshold
#     # Do stuff here
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot threshold global squelch - Sets the room-level threshold to 0
#   hubot threshold global set <value> - Sets the room-level threshold
#   hubot threshold global clear - Removes the room-level threshold. Scripts will use their configured thresholds instead
#   hubot threshold set <threshold-name> <value> - Creates or updates a threshold
#   hubot threshold remove <threshold-name> - Removes a threshold
#   hubot threshold list [threshold-name] - Displays the value of threshold or all thresholds
#
# Author:
#   Matt Rick2
#

class ThresholdStorage
  constructor: (@robot) ->
    @thresholds = {}
    @robot.brain.on 'loaded', =>
      @thresholds = @robot.brain.data.thresholds || {}

  roomThresholds : (msg) ->
    room = msg.message.room
    result = @thresholds[room]

    if (!result)
      result = {}
      @thresholds[room] = result
    result

  setThreshold : (msg, scriptName, threshold) ->
    @roomThresholds(msg)[scriptName] = threshold
    @save()


  getThreshold : (msg, scriptName, defaultThreshold) ->
    roomThreshold = @roomThresholds(msg)[generateRoomThresholdName(msg)]
    threshold = @roomThresholds(msg)[scriptName]
    if !threshold? && defaultThreshold?
      threshold = defaultThreshold
      @setThreshold(msg, scriptName, threshold)

    if !roomThreshold?
      threshold
    else
      roomThreshold

  save : ->
    @robot.brain.data.thresholds = @thresholds

  remove : (msg, scriptName) ->
      delete @roomThresholds(msg)[scriptName]
      @save()

module.exports = (robot) ->

  robot.thresholdStorage = new ThresholdStorage robot

  robot.respond /threshold global squelch/i, (msg) ->
    globalName = generateRoomThresholdName(msg)
    validateThreshold(msg, globalName, 0)
    msg.send "Setting global threshold to 0%. Scripts will ignore their configured thresholds."

  robot.respond /threshold global (add|set) ([0-9\.]+)/i, (msg) ->
    globalName = generateRoomThresholdName(msg)
    validateThreshold(msg, globalName, msg.match[2])
    msg.send "Setting global threshold to #{robot.thresholdStorage.getThreshold(msg, globalName) * 100}%. Scripts will ignore their configured thresholds.";

  robot.respond /threshold global (clear|delete|remove)/i, (msg) ->
    globalName = generateRoomThresholdName(msg)
    robot.thresholdStorage.remove(msg, globalName)
    msg.send "Removing global threshold. Scripts will resume using their configured thresholds."

  robot.respond /threshold (add|set) ([a-zA-z0-9_\-]+) ([0-9\.]+)/i, (msg) ->
    scriptName = msg.match[2]
    threshold = msg.match[3]
    validateThreshold(msg, scriptName, threshold)
    msg.send "#{scriptName}'s threshold is now #{robot.thresholdStorage.getThreshold(msg, scriptName) * 100}%."

  robot.respond /threshold (clear|delete|remove) ([a-zA-z0-9_\-]+)/i, (msg) ->
    scriptName = msg.match[2]
    robot.thresholdStorage.remove(msg, scriptName)
    msg.send "#{scriptName}'s threshold removed - using default."

  robot.respond /threshold list ?([a-zA-z0-9_\-]+)?/i, (msg) ->
    if msg.match[1]?
      scriptName = msg.match[1]
      threshold = robot.thresholdStorage.getThreshold(msg, scriptName)
      if threshold
        msg.send "#{scriptName}'s threshold is #{threshold * 100}%."
      else
        msg.send "#{scriptName} has no room specific threshold set."
    else
      thresholdList = []
      roomLevelThreshold = false
      roomLevelName = generateRoomThresholdName(msg)
      for scriptName, threshold of robot.thresholdStorage.roomThresholds msg
        if !(roomLevelName == scriptName)
          thresholdList.push "#{scriptName} - #{threshold * 100}%"
        else
          roomLevelThreshold = true
      if roomLevelThreshold
        thresholdList.push("(failed) These thresholds have been overridden by a room-level threshold")
        thresholdList.push("(failed) The room-level threshold is #{robot.thresholdStorage.getThreshold(msg, roomLevelName) * 100}%")
      msg.send thresholdList.join("\n")

generateRoomThresholdName = (msg) ->
  "global-#{msg.message.room}"

validateThreshold = (msg, scriptName, threshold) ->
  if threshold <= 100 && threshold > 1
    threshold = threshold / 100
  else if threshold > 100
    msg.reply "I really can't turn up to 11."
    return
  robot.thresholdStorage.setThreshold(msg, scriptName, threshold)
