# Description:
#   Display a random mean girls quote
#   Fetch Generates Mean girls quote and gif. Threshold enabled
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot Mean Girls quote - displays a random Mean Girls quote. 
#
# Author:
#   Lymari Montijo
#   Chantal Lewis

quotes = [
  'You can\'t sit with us!'
  'I\'m kind of psychic. I have a fifth sense.'
  'But you\'re like really pretty.'
  'So you agree? You think you\'re really pretty?'
  'That is so fetch!'
  'Stop trying to make fetch happen! It\'s not going to happen!'
  'That\'s why her hair is so big. It\'s full of secrets.'
  'I\'m a mouse DuH!..'
  'Oh my God, Danny DeVito I love your work!'
  'She doesn\'t even go here!'
  'I can\'t go out, I\'m sick. *cough* *cough*'
  'Grool. I meant to say great but then I started to say cool.'
  'I\'m sorry that people are so jealous of me. But I can\'t help it that I\'m popular.'
  'And none for Gretchen Wieners, bye.'
  'And I want my pink shirt back!'
  'Glenn Coco? FOUR for you, Glenn Coco! You go, Glenn Coco.'
  'Get in loser, we\'re going shopping?'
  'Is butter a carb?'
  'I\'m not a regular mom, I\'m a cool mom.'
  'On Wednesdays we wear pink.'
  'I wish I could bake a cake filled with rainbows and smiles and everyone would eat and be happy.'
  'The limit does not exist.'
  'Don\'t let the haters stop you from doing your thang.'
  'My nana takes her wig off when she\'s drunk.'
  'It\'s October 3rd.'


];
threshold = 0.75

module.exports = (robot) ->
  robot.respond /Mean girls quote/i, (msg) ->
    msg.reply(msg.random quotes)

  robot.hear /fetch/i, (message)->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "fetch", threshold)
    if random < roomThreshold
      message.send "Stop trying to make fetch happen! It\'s not going to happen!"
      message.send 'https://s3.amazonaws.com/uploads.hipchat.com/171096/4014356/zTIwhGvT1lCKANW/mean_girls.gif'
