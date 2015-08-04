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
#   hubot food me - Returns a random skyway restaurant
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
  'Which Wich'
]

module.exports = (robot) ->

  robot.hear /food ?me/i, (msg) ->
    msg.send msg.random skyway_restaurants
