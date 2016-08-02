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
  robot.respond /cafe menu CC/i, (msg) ->
    msg.send "CC Menu: " + ccMenu

  robot.respond /cafe menu TNC/i, (msg) ->
    msg.send "TNC menu: " + tncMenu

  robot.respond /cafe menu TPS/i, (msg) ->
    msg.send "TPS menu: " + tpsMenu
