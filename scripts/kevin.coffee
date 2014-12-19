# Description:
#   Kevin Behrens awesomeness
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot kevin me -- random Kevin awesomeness

# Author:
#   akorver

module.exports = (robot) ->

  robot.respond /(kevin)( me )?(.*)/i, (msg)->

      askChuck msg, "http://api.icndb.com/jokes/random?firstName=Kevin"+"&lastName="

  askChuck = (msg, url) ->
    msg.http(url)
      .get() (err, res, body) ->
        if err
          msg.send "Chuck Norris says: #{err}"
        else
          message_from_chuck = JSON.parse(body)
          if message_from_chuck.length == 0
            msg.send "Achievement unlocked: Chuck Norris is quiet!"
          else
            msg.send message_from_chuck.value.joke.replace /\s\s/g, " "
