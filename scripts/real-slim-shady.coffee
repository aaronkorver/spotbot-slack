# Description:
#   Decide who the real Slim Shady is once and for all.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot who's the real slim shady? - Picks a user in the room to declare as the real Slim Shady
#
# Author:
#   Matthew Dordal

module.exports = (robot) ->

  users = robot.brain.data.users

  robot.respond /who's the real Slim Shady\?/i, (msg) ->
    theRealSlimShady(users, msg)

theRealSlimShady = (users, msg) ->
  me = msg.message.user.name
  comeAtMeBro = '@' + me + ', is the real Slim Shady. All those other Slim Shady\'s are just imitating.'
  list = [];

  for key, value of users
    list.push( "#{value.name}" )


  if list.length == 0
    msg.send 'I\'m the real Slim Shady!'
    return
  else if me == 'MatthewDordal'
    msg.send comeAtMeBro
    return
  else
    user = msg.random list
    msg.send "@#{user} is the real Slim Shady."
    return
