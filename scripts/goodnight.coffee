# Description:
#   Good Night
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot good night
#
# Author:
#  BrentNelson

goodNights = [
    "Good night my human pet, sweet dreams"
    "Sweet dreams"
    "Good night!"
    "Bon nuit"
    "Buenas noches"
    "Hasta la vista baby"
    "Farewell, friend"
]


module.exports = (robot) ->
  robot.respond /(good ?night)/i, (msg) ->
    msg.send msg.random goodNights
