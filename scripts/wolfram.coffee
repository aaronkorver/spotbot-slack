# Description:
#   Allows hubot to answer almost any question by asking Wolfram Alpha
#
# Dependencies:
#   "wolfram": "0.2.2"
#
# Configuration:
#   HUBOT_WOLFRAM_APPID - your AppID
#
# Commands:
#   hubot tell me <question> - Searches Wolfram Alpha for the answer to the question
#
# Author:
#   dhorrigan

wolfram = require('wolfram').createClient(process.env.HUBOT_WOLFRAM_APPID)

module.exports = (robot) ->
  robot.respond /(question|wfa|wolfram|tell)( me)? (.*)/i, (msg) ->
    #console.log msg.match
    wolfram.query msg.match[3], (e, result) ->
      console.log result
      #json = JSON.parse(result)
      #console.log json
      if result and result.length > 0
        msg.send result [1]['subpods'][0]['value']
      else
        msg.send 'Hmm...not sure'
