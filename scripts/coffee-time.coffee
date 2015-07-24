# Description:
#   I WANT COFFEE
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Coffee - Display a coffee gif when someone mentions coffee
#
# Author:
#   therynamo
#

threshold = 0.50
coffeeGifs= [
    'https://s3.amazonaws.com/uploads.hipchat.com/171096/1531191/L8I7tI87ESXCI4n/ZeA4YK5.jpg'
    'https://s3.amazonaws.com/uploads.hipchat.com/171096/1611704/ryhIlFkfCgzwJe7/coffee-time.gif'
    'http://media.giphy.com/media/O7OZszv0uX4I0/giphy.gif'
    'http://media.giphy.com/media/VerIk7pS3iEEg/giphy.gif'
    'http://media.giphy.com/media/5xtDarF1RQvns8iE1vq/giphy.gif'
    'http://media.giphy.com/media/M5myuxwZaK2J2/giphy.gif'
    'http://media3.giphy.com/media/U6P1Lp8tbZBfy/giphy.gif'
    'http://media.giphy.com/media/TON7phe0r94Dm/giphy.gif'
    'http://media.giphy.com/media/UcYLVbE8rQsBa/giphy.gif'
    'http://media.giphy.com/media/11Lz1Y4n1f2j96/giphy.gif'
    'http://media.giphy.com/media/NHUONhmbo448/giphy.gif'
    'http://media.giphy.com/media/bIoHUGOzzdrzO/giphy.gif'
    'http://media.giphy.com/media/5yLgocoIKT7d0pqUFS8/giphy.gif'
]

module.exports = (robot) ->
  robot.hear /(^|[^\.])\bcoffee\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "coffee-time") || threshold
    if random < roomThreshold
      msg.send msg.random coffeeGifs
