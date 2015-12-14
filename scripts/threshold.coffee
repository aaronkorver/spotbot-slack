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
    threshold = @roomThresholds(msg)[scriptName]
    if !threshold? && defaultThreshold?
      threshold = defaultThreshold
      @setThreshold(msg, scriptName, threshold)
    threshold

  save : ->
    @robot.brain.data.thresholds = @thresholds

  remove : (msg, scriptName) ->
      delete @roomThresholds(msg)[scriptName]
      @save()

module.exports = (robot) ->

  robot.thresholdStorage = new ThresholdStorage robot

  robot.respond /threshold (set|add) ([a-zA-z0-9_\-]+) ([0-9\.]+)/i, (msg) ->
    scriptName = msg.match[2]
    threshold = msg.match[3]
    validateThreshold(msg, scriptName, threshold)
    msg.send "#{scriptName}'s threshold is now #{robot.thresholdStorage.getThreshold(msg, scriptName) * 100}%."

  robot.respond /threshold (delete|remove) ([a-zA-z0-9_\-]+)/i, (msg) ->
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
      for scriptName, threshold of robot.thresholdStorage.roomThresholds msg
        thresholdList.push "#{scriptName} - #{threshold * 100}%"
      msg.send thresholdList.join("\n")

validateThreshold = (msg, scriptName, threshold) ->
  if threshold <= 100 && threshold > 1
    threshold = threshold / 100
  else if threshold > 100
    msg.reply "I really can't turn up to 11."
    return
  robot.thresholdStorage.setThreshold(msg, scriptName, threshold)
