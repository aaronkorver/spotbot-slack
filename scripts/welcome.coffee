# Description:
#   Welcomes a new user to the room
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot welcome `@username`
#
# Author:
#   therynamo




module.exports = (robot) ->
  robot.respond /(welcome)( @.*)/i ,(msg) ->
    user = msg.match[2]

    welcomes = [
        "Welcome#{user}! (awesome)"
        "Holy Cow!#{user} is here!? (awwyiss)"
        "#{user}! Where have you been my entire life!?"
        "#{user} is here, the party is now officially started."
        "What am I? Chopped liver!? why is #{user} so special? (feelsbadman)"
        "Yay! another user to boss me around. Please be nice to me,#{user}."
        "Welcome#{user}, I hope you're more interesting than @MattRick"
        "Welcome#{user}. It is customary to buy everyone in the room coffee..."
        "Welcome#{user}! You're my new favorite. To tell the truth I don't like any of these other people."
    ]

    msg.send msg.random welcomes
