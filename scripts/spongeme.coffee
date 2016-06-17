# Description:
#   Random SpongeBob gif generator
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   sponge me - Displays a random spongebob gif
#
# Author:
#   Lymari Montijo

spongeGifs = [
  'http://i.giphy.com/beLG3rdCb9fdS.gif'
  'http://i.giphy.com/HxOxEt3qQ25YQ.gif'
  'http://i.giphy.com/LdOyjZ7io5Msw.gif'
  'http://i.giphy.com/43sMhXiELKzNm.gif'
  'http://i.giphy.com/TgIvQCIOoc78k.gif'
  'http://i.giphy.com/X4M6homF66qFq.gif'
  'http://i.giphy.com/7YeguV6Ia9lfO.gif'
  'http://i.giphy.com/3E0czvVwdjo2I.gif'
  'http://i.giphy.com/vaq9VvnAHlsEo.gif'
  'http://i.giphy.com/QV8RROsO4wjzW.gif'
  'http://i.giphy.com/HcwAhlzuJQHDO.gif'
]

module.exports = (robot) ->
  robot.hear /sponge ?me/i, (msg) ->
    msg.send msg.random spongeGifs
