# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cafe menu CC - Gives url for CC lunch menu
#   hubot cafe menu TNC - Gives url for TNC lunch menu
#   hubot cafe menu TPS - Gives url for TPS lunch menu
#
# Author:
#   Jordan McGowan

ccMenu = "http://target.cafebonappetit.com/cafe/bullseye-cafe/"
tncMenu = "http://target.cafebonappetit.com/cafe/traders-point/"
tpsMenu = "http://target.cafebonappetit.com/cafe/cafe-target/"

module.exports = (robot) ->

  robot.respond /cafe menu (.*)/i, (msg) ->
    if msg.match[1].toLowerCase() == "cc" || msg.match[1].toLowerCase() == "city center"
      msg.send "CC Menu " + ccMenu

  robot.respond /cafe menu (.*)/i, (msg) ->
    if msg.match[1].toLowerCase() == "tnc" || msg.match[1].toLowerCase() == "north campus" || msg.match[1].toLowerCase() == "target north campus"
      msg.send "TNC Menu " + tncMenu

  robot.respond /cafe menu (.*)/i, (msg) ->
    if msg.match[1].toLowerCase() == "tps" || msg.match[1].toLowerCase() == "plaza south" || msg.match[1].toLowerCase() == "target plaza south" || msg.match[1].toLowerCase() == "tpn" || msg.match[1].toLowerCase() == "plaza north" || msg.match[1].toLowerCase() == "target plaza north" || msg.match[1].toLowerCase() == "tp3"
      msg.send "TPS Menu " + tpsMenu
