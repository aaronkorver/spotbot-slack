# Description:
#   Hubot picks consults a magic 8 ball and reports the results.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot magic8ball
#
# Author:
#   dev-null-matt
#

prophesy = [
    'It is certain',
    'It is decidedly so',
    'Without a doubt',
    'Yes definitely',
    'You may rely on it',
    'As I see it, yes',
    'Most likely',
    'Outlook good',
    'Yes',
    'Signs point to yes',
    'Reply hazy try again',
    'Ask again later',
    'Better not tell you now',
    'Cannot predict now',
    'Concentrate and ask again',
    'Don\'t count on it',
    'My reply is no',
    'My sources say no',
    'Outlook not so good',
    'Very doubtful'
]
# set up our prefix
# unicode ➑ example: '\u2791'
eightBallPrefix = '\u2791: '

module.exports = (robot) ->
  robot.respond /(?:magic\s)?(eight|8)[ ]?ball/i, (msg) ->
    msg.send eightBallPrefix+msg.random prophesy
