# Description:
#   Pee Wee Problem
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot the secret word is <word> - changes secret word to <word> if user is admin
#   hubot what is the secret word - tells you the secret word if user is admin
#
# Author:
#   Jordan McGowan and Rory Straubel

secretWord = "astrobleme"
done = [
  "Consider it done"
  "You got it, coach"
  "Anything you say"
]

module.exports = (robot) ->

  unless process.env.SPOTBOT_PEEWEE_ADMIN?
    robot.logger.warning 'The SPOTBOT_PEEWEE_ADMIN environment variable not set'

  if process.env.SPOTBOT_PEEWEE_ADMIN?
    admins = process.env.SPOTBOT_PEEWEE_ADMIN.split ','
  else
    admins = []

  robot.respond /what is the secret word/i, (msg) ->
    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name

    if sender in admins
      msg.send "The secret word is " + secretWord
    else
      msg.send "You are not an admin, you cannot do that!"

  robot.respond /the secret word is (.*)/i, (msg) ->
    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name

    if sender in admins
      secretWord = msg.match[1]
      msg.send msg.random done
    else
      msg.send "You are not an admin, you cannot do that!"

  robot.hear //, (msg) ->
    patt = new RegExp secretWord
    if patt.test(msg.message)
      msg.send "YOU SAID THE SECRET WORD! EVERYBODY SCREAM REAL LOUD!"
      msg.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/2268827/ZzKYO7E7K2nZu8v/ZWARaOZ.gif"
