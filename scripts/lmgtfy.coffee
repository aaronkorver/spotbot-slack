# Description:
#   Tell Hubot to get a tinyurl link to lmgtfy.com
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot lmgtfy <some query>
#
# Author:
#  Kevin Behrens 

module.exports = (robot) ->
   robot.respond /lmgtfy (.*)/i, (msg) ->
     msg.http("http://tinyurl.com/api-create.php?url=http://lmgtfy.com/?q=#{encodeURI(msg.match[1])}")
       .get() (error, response, body) ->
         if error
           msg.send "ruh ro... you might actually have to google it, something with wrong: #:{error}"
         else 
           msg.send body
