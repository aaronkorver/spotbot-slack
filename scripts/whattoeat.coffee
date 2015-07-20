# Description:
#
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot what should I eat => random Skyway restaurant
#
# Author:
#   Ashley Montgomery, Sara Schram, Katrina Schreiber, Jiaqi Chen, Jonathon Lacher
skyway_restaurants = [
  'Bombay Bistro'
  'Real Meal Deli'
  'Skyway Wok'
  'Sorrento Cucina'
  'Chipotle'
  'Subway'
  'Atlas Grill'
  'Tea House'
  'Asian Max'
  'Zelo'
  'Valentino Cafe'
  'Angel Food Bakery and Coffee Bar'
  'Seven Sushi'
  'Barrio'
  'Hen House Eatery'
  'Leann Chin'
  'Taco John\'s'
  'Which Which'
]

module.exports = (robot) ->

  robot.respond /(what)( should)( I)( eat)?/i, (msg) ->
    response = msg.random skyway_restaurants
    msg.send ('You should eat at: "' + response + '"')
