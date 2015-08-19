# Description:
#   Chuck Norris awesomeness
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot chuck norris -- random Chuck Norris awesomeness
#   hubot chuck norris me <user> -- let's see how <user> would do as Chuck Norris
#
# Author:
#   dlinsin

String::strip = -> if String::trim? then @trim() else @replace /^\s+|\s+$/g, ""


module.exports = (robot) ->

  robot.respond /(chuck norris)(\sme)?(\s\w+)?(\s\w+)?/i, (msg)->
    firstName = msg.match[3]?.strip()
    lastName = msg.match[4]?.strip() ? lastname=""

    if (typeof firstName != "undefined")
      askChuck msg, "http://api.icndb.com/jokes/random?exclude=[explicit]&firstName="+firstName+"&lastName="+lastName
    else
      askChuck msg, "http://api.icndb.com/jokes/random?exclude=[explicit]"

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
            msg.send message_from_chuck.value.joke.replace(/\s\s/g, " ").replace(/&quot;/g, "\"")
