# Description:
#   Mark when lights are turned off and on
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot lights off - mark when the lights are turned off
#   hubot lights on - mark when the lights are turned on
#   hubot lights report [amount] - Show last [amount] of lights off/on records and a top level report
#
# Author:
#   russellsanborn
#

moment = require('moment')

class LightsStorage
  constructor: (@robot) ->
    @events = new Array()

    @robot.brain.on 'loaded', =>
      @events = @robot.brain.data.events || new Array()

  addEvent : (date, status, durationInSeconds) ->
    if (durationInSeconds)
      @events.push("#{status} - #{date} - OFF Duration: #{durationInSeconds} Seconds")
    else
      @events.push("#{status} - #{date}")

module.exports = (robot) ->

    lightsStorage = new LightsStorage robot

    robot.respond /lights off/i, (msg) ->
      lastMessage = lightsStorage.events[lightsStorage.events.length - 1]

      if (lastMessage && lastMessage.indexOf('OFF') == 0)
        msg.send "The lights are already OFF. Log an ON event first"
      else
        lightsStorage.addEvent(moment().format('YYYY-MM-DD HH:mm:ss'), 'OFF')
        msg.send "Added light event #{lightsStorage.events[lightsStorage.events.length - 1]}"

    robot.respond /lights on/i, (msg) ->
      lastMessage = lightsStorage.events[lightsStorage.events.length - 1]

      if (lastMessage && lastMessage.indexOf('ON') == 0)
        msg.send "The lights are already ON. Log an OFF first"
      else if (lastMessage && lastMessage.indexOf('OFF') > -1)
        currentTime = moment()
        previousTime = moment(lastMessage.split(" - "), "YYYY-MM-DD HH:mm:ss")
        durationInSeconds = (currentTime - previousTime) / 1000
        lightsStorage.addEvent(currentTime.format('YYYY-MM-DD HH:mm:ss'), 'ON', durationInSeconds)
        msg.send "Added light event #{lightsStorage.events[lightsStorage.events.length - 1]}"
      else
        lightsStorage.addEvent(moment().format('YYYY-MM-DD HH:mm:ss'), 'ON')
        msg.send "Added light event #{lightsStorage.events[lightsStorage.events.length - 1]}"

    robot.respond /lights report( \d+)?/i, (msg) ->
      amount = parseInt(msg.match[1]) || 5
      queryAmount = Math.min(amount, lightsStorage.events.length)
      reversedEvents = lightsStorage.events.slice(0)
      eventsToReport = reversedEvents.reverse().slice(0, queryAmount)

      lines = ["Total Light Toggles: #{lightsStorage.events.length}"]
      for event in eventsToReport
        lines.push(event)
      msg.send lines.join("\n")
