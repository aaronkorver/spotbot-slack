# Description:
#   Search the Target Wiki for the provided terms
#
# Commands:
#   hubot wiki <search terms> -- search the Target Wiki for anything
#
# Author:
#   jamesanderson

module.exports = (robot) ->
  robot.respond /(wiki)(.*)/i, (msg)->
    terms = escape(msg.match[2].slice(1))

    if terms.length == 0
      response = "http://wiki.target.com/tgtwiki/index.php/Special:Random"
    else
      response = "http://wiki.target.com/tgtwiki/index.php?search="+terms+"&title=Special%3ASearch&go=Go"

    msg.send response
