# Description
#    Ron Paul Revolution
# 
# Dependencies
#    None
#
# Confiuration:
#    None
#
# Commands:
#    It's Happening - Ron Paul Revolution
#
# Author
#    Hatz & Gang


module.exports = (robot) ->
  robot.hear /it'?s\s?happening/i, (message) -> 
    message.send "http://i.imgur.com/7drHiqr.gif"		
